<?php
require_once __DIR__.'/php/htmlCore.php';
require_once __DIR__.'/../api/youth_survey_storage.php';
header('Cache-Control: no-store, private');
header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: SAMEORIGIN');
$db=(new DBControl())->connect;
$adminId=filter_var($_COOKIE['user']??'',FILTER_VALIDATE_INT);
if(!$adminId){header('Location: login.php');exit;}
$admin=youth_sql($db,'SELECT user_type FROM user WHERE user_id=?','i',[$adminId])->get_result()->fetch_assoc();
if(!$admin || $admin['user_type']!=='admin'){http_response_code(403);exit('หน้านี้สำหรับผู้ดูแลระบบเท่านั้น');}
function yh($s){return htmlspecialchars((string)$s,ENT_QUOTES,'UTF-8');}
function yg($key,$default=''){return isset($_GET[$key])&&is_string($_GET[$key])?$_GET[$key]:$default;}
$area=yg('area');$status='active';$group=yg('group');
$areas=$db->query("SELECT * FROM youth_survey_areas ORDER BY CASE code WHEN 'thung_saliam' THEN 1 WHEN 'nam_phai' THEN 2 WHEN 'public_health' THEN 3 ELSE 4 END, id")->fetch_all(MYSQLI_ASSOC);
if($area!=='' && !in_array($area,array_column($areas,'code'),true)){if(yg('export')==='xlsx'){http_response_code(400);exit('ตัวกรองพื้นที่ไม่ถูกต้อง');}$area='';}
if(!in_array($status,['active','withdrawn','all'],true)){if(yg('export')==='xlsx'){http_response_code(400);exit('ตัวกรองสถานะไม่ถูกต้อง');}$status='active';}
$groupOptions=[];
if(in_array($area,['thung_saliam','nam_phai','public_health'],true)) {
    foreach(youth_schema($area)['questions'] as $q) if($q['id']==='s1q5') $groupOptions=$q['options'];
    $historical=youth_sql($db,"SELECT DISTINCT COALESCE(v.option_text, v.text_value) AS label FROM youth_survey_answer_report v JOIN youth_survey_responses r ON r.id=v.response_id WHERE r.area_code=? AND v.question_code='s1q5' AND v.status='answered'",'s',[$area])->get_result()->fetch_all(MYSQLI_ASSOC);
    foreach($historical as $row) if($row['label']!==null && $row['label']!=='' && !in_array($row['label'],$groupOptions,true)) $groupOptions[]=$row['label'];
}
if($group!=='' && !in_array($group,$groupOptions,true)){if(yg('export')==='xlsx'){http_response_code(400);exit('ตัวกรองหมู่หรือสาขาไม่ถูกต้อง');}$group='';}
$page=max(1,(int)yg('page','1'));$id=max(0,(int)yg('id','0'));
$where=' WHERE 1=1';$types='';$params=[];
if($area!==''){$where.=' AND ar.code=?';$types.='s';$params[]=$area;}
if($status!=='all'){$where.=' AND r.withdrawn=?';$types.='i';$params[]=$status==='withdrawn'?1:0;}
if($group!==''){$where.=" AND EXISTS (SELECT 1 FROM youth_survey_answer_report gv WHERE gv.response_id=r.id AND gv.question_code='s1q5' AND gv.status='answered' AND (gv.option_text=? OR gv.text_value=?))";$types.='ss';$params[]=$group;$params[]=$group;}
$join=' FROM youth_survey_responses r JOIN youth_survey_response_details d ON d.response_id=r.id JOIN youth_survey_forms f ON f.id=d.form_id JOIN youth_survey_areas ar ON ar.id=f.area_id';
if(yg('export')==='xlsx') {
    require_once __DIR__.'/php/youth_survey_xlsx.php';
    require_once __DIR__.'/php/youth_survey_latest.php';
    $where=youth_latest_export_where($where,$status);
    try {
        youth_export_xlsx($db,$join,$where,$types,$params,$area,$status,$group);
    } catch (Throwable $e) {
        $db->rollback();
        while(ob_get_level()>0) ob_end_clean();
        error_log('Youth survey Excel export failed: '.get_class($e));
        http_response_code(500);
        header('Content-Type: text/plain; charset=utf-8');
        echo 'ไม่สามารถสร้างไฟล์ Excel ได้ กรุณาลองอีกครั้ง';
    }
    exit;
}
$total=(int)youth_sql($db,'SELECT COUNT(*) AS n'.$join.$where,$types,$params)->get_result()->fetch_assoc()['n'];
$pages=max(1,(int)ceil($total/25));$page=min($page,$pages);$offset=($page-1)*25;
$rows=youth_sql($db,'SELECT r.id,r.created_at,r.withdrawn,ar.subdistrict,ar.district,ar.province,f.version, (SELECT COUNT(*) FROM youth_survey_answers a WHERE a.response_id=r.id AND a.status="answered") AS answered'.$join.$where.' ORDER BY r.id DESC LIMIT 25 OFFSET '.$offset,$types,$params)->get_result()->fetch_all(MYSQLI_ASSOC);
$columns=youth_schema($area?:'thung_saliam',true)['questions'];
$answersByResponse=[];
if($rows){
 $ids=array_column($rows,'id');$marks=implode(',',array_fill(0,count($ids),'?'));
 $answers=youth_sql($db,"SELECT response_id,question_code,answer_type,status,text_value,option_text FROM youth_survey_answer_report WHERE response_id IN ($marks) ORDER BY section_number,question_number,CAST(option_code AS UNSIGNED)",str_repeat('i',count($ids)),$ids)->get_result();
 while($answer=$answers->fetch_assoc()){
  if($answer['status']!=='answered')continue;
  $value=$answer['answer_type']==='text'?$answer['text_value']:$answer['option_text'];
  if($value!==null && $value!=='')$answersByResponse[$answer['response_id']][$answer['question_code']][]=$value;
 }
}
$summary=youth_sql($db,'SELECT ar.subdistrict,COUNT(*) AS n'.$join.$where.' GROUP BY ar.id,ar.subdistrict ORDER BY ar.id',$types,$params)->get_result()->fetch_all(MYSQLI_ASSOC);
$detail=[];$header=null;
if($id){
 $header=youth_sql($db,'SELECT r.id,r.created_at,r.withdrawn,ar.subdistrict,ar.district,ar.province,f.version'.$join.$where.' AND r.id=?',$types.'i',array_merge($params,[$id]))->get_result()->fetch_assoc();
 if(!$header){http_response_code(404);}
 else {
  $data=youth_sql($db,'SELECT s.section_number,s.title AS section_title,q.code AS question_code,q.question_number,q.question_text,q.answer_type,a.status,a.text_value,o.option_text FROM youth_survey_response_details d JOIN youth_survey_sections s ON s.form_id=d.form_id JOIN youth_survey_questions q ON q.section_id=s.id LEFT JOIN youth_survey_answers a ON a.response_id=d.response_id AND a.question_id=q.id LEFT JOIN youth_survey_answer_choices c ON c.answer_id=a.id LEFT JOIN youth_survey_options o ON o.id=c.option_id WHERE d.response_id=? ORDER BY s.section_number,q.question_number,CAST(o.option_code AS UNSIGNED)','i',[$id])->get_result()->fetch_all(MYSQLI_ASSOC);
  foreach($data as $r){$key=$r['question_code'];if(!isset($detail[$key])){$detail[$key]=$r;$detail[$key]['choices']=[];}if($r['option_text']!==null)$detail[$key]['choices'][]=$r['option_text'];}
 }
}
function yurl($extra=[]){global $area,$status,$group;return 'youth_survey_report.php?'.http_build_query(array_merge(['area'=>$area,'status'=>$status,'group'=>$group],$extra));}
function youthAreaLabel($row){return $row['province']===''?$row['subdistrict']:'ต.'.$row['subdistrict'].' อ.'.$row['district'].' จ.'.$row['province'];}
?>
<!doctype html><html lang="th"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>ผลแบบสอบถามเด็กและเยาวชน | TRC Admin</title>
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"><link rel="stylesheet" href="css/font-awesome.min.css"><link rel="stylesheet" href="dist/css/AdminLTE.css"><link rel="stylesheet" href="dist/css/skins/skin-blue-light.css"><link href="https://fonts.googleapis.com/css?family=Kanit" rel="stylesheet">
<style>body{font-family:Kanit,sans-serif}.survey-filter{display:flex;gap:14px;flex-wrap:wrap;align-items:end}.survey-filter label{display:block}.survey-filter .form-control{min-width:180px}.survey-note{color:#606f80;margin:12px 0}.survey-stats{display:flex;gap:12px;flex-wrap:wrap;margin:16px 0}.survey-stat{background:#fff;border-top:3px solid #3c8dbc;padding:15px 22px;min-width:160px}.survey-stat strong{display:block;font-size:26px}.survey-answer{padding:16px 0;border-bottom:1px solid #e3e8ee;overflow-wrap:anywhere}.survey-answer h4{font-size:16px;line-height:1.7}.survey-answer p{white-space:pre-wrap}.survey-answers th,.survey-answers td{min-width:180px;max-width:260px;white-space:normal!important;overflow-wrap:anywhere;vertical-align:top!important}.survey-answers th:first-child,.survey-answers td:first-child{min-width:75px}.survey-answers th span{font-weight:400}.survey-empty{padding:28px;text-align:center;color:#667}.survey-meta{line-height:1.9}.box-body{padding:20px}@media(max-width:767px){.content-wrapper{margin-left:0}.main-sidebar{display:none}.survey-filter>div{width:100%}}</style></head>
<body class="hold-transition skin-blue-light"><div class="wrapper"><header class="main-header"><?php HtmlCore::getTextHeader();?><nav class="navbar navbar-static-top"><a href="index.php" class="navbar-brand" style="font-size:16px">ระบบหลังบ้าน</a><?php HtmlCore::getMenuHeader();?></nav></header>
<aside class="main-sidebar"><section class="sidebar"><?php HtmlCore::getMenu('youth_survey_report');?></section></aside>
<div class="content-wrapper"><section class="content-header"><h1>ผลแบบสอบถามเด็กและเยาวชน</h1></section><section class="content">
<div class="box box-primary"><div class="box-body"><form method="get" class="survey-filter"><div><label for="area">พื้นที่ / คณะ</label><select class="form-control" id="area" name="area" onchange="document.getElementById('group').value='';this.form.submit()"><option value="">ทุกพื้นที่</option><?php foreach($areas as $a):?><option value="<?=yh($a['code'])?>" <?=$area===$a['code']?'selected':''?>><?=yh(youthAreaLabel($a))?></option><?php endforeach;?></select></div>
<div <?=$groupOptions?'':'hidden'?>><label for="group"><?=$area==='public_health'?'สาขาวิชา':'หมู่บ้าน'?></label><select class="form-control" id="group" name="group"><option value=""><?=$area==='public_health'?'ทุกสาขา':'ทุกหมู่บ้าน'?></option><?php foreach($groupOptions as $option):?><option value="<?=yh($option)?>" <?=$group===$option?'selected':''?>><?=yh($option)?></option><?php endforeach;?></select></div>
<button class="btn btn-primary" type="submit">แสดงข้อมูล</button></form>
<p style="margin-top:16px"><a class="btn btn-success" href="<?=yh(yurl(['export'=>'xlsx']))?>"><i class="fa fa-download" aria-hidden="true"></i> ดาวน์โหลด Excel ตามตัวกรอง</a> <span class="survey-note">ส่งออกเฉพาะชุดล่าสุดของผู้ใช้แต่ละคนในแต่ละตำบลตามตัวกรอง ข้อมูลเดิมที่ไม่มีรหัสอ้างอิงยังคงแสดงแยกชุด หากเปลี่ยนตัวกรองให้กด “แสดงข้อมูล” ก่อน</span></p>
<p class="survey-note">ไม่แสดงชื่อหรือบัญชีผู้ตอบ · ตัวเลขนับตามชุดคำตอบ ไม่ซ้ำตามจำนวนตัวเลือก</p><?php if($status!=='active'):?><div class="alert alert-warning">กำลังแสดงคำตอบที่อาจมีข้อมูลทดสอบหรือคำตอบที่ถอนแล้ว โปรดใช้ตัวกรอง “ใช้วิเคราะห์” สำหรับรายงานจริง</div><?php endif;?></div></div>
<div class="survey-stats"><div class="survey-stat">ชุดคำตอบตามตัวกรอง<strong><?=number_format($total)?></strong></div><?php foreach($summary as $s):?><div class="survey-stat"><?=yh($s['subdistrict'])?><strong><?=number_format($s['n'])?></strong></div><?php endforeach;?></div>
<?php if($id && !$header):?><div class="alert alert-info">ไม่พบชุดคำตอบนี้ภายใต้ตัวกรองที่เลือก</div><?php endif;?>
<?php if($header):?><div class="box box-primary"><div class="box-header with-border"><h2 class="box-title">คำตอบชุดที่ #<?=yh($header['id'])?></h2> <a class="btn btn-default btn-sm pull-right" href="<?=yh(yurl(['page'=>$page]))?>">กลับรายการ</a></div><div class="box-body"><p class="survey-meta"><?=yh(youthAreaLabel($header))?><br>ส่งเมื่อ <?=yh($header['created_at'])?> (เวลาไทย) · รุ่น <?=yh($header['version'])?><br>สถานะ: <?=$header['withdrawn']?'ไม่นำไปวิเคราะห์ / ข้อมูลทดสอบ':'ใช้วิเคราะห์'?> · ตอบแล้ว <?=count(array_filter($detail,fn($a)=>$a['status']==='answered'))?> / 30 ข้อ</p>
<?php $section=0;foreach($detail as $answer):if($section!==$answer['section_number']):$section=$answer['section_number'];?><h3>ส่วนที่ <?=yh($section)?>: <?=yh($answer['section_title'])?></h3><?php endif;?><div class="survey-answer"><h4><?=yh($answer['question_number'].'. '.$answer['question_text'])?></h4><?php if($answer['status']!=='answered'):?><p class="text-muted">-</p><?php elseif($answer['answer_type']==='text'):?><p><?=yh($answer['text_value']!==null && $answer['text_value']!==''?$answer['text_value']:'-')?></p><?php elseif(!$answer['choices']):?><p class="text-muted">-</p><?php else:?><ul><?php foreach($answer['choices'] as $choice):?><li><?=yh($choice)?></li><?php endforeach;?></ul><?php endif;?></div><?php endforeach;?></div></div><?php endif;?>
<div class="box"><div class="box-header with-border"><h2 class="box-title">รายการคำตอบ</h2></div><div class="box-body"><div class="table-responsive"><table class="table table-striped survey-answers"><thead><tr><th>ชุดที่</th><th>พื้นที่</th><?php foreach($columns as $q):?><th>ส่วน <?=$q['section']?> ข้อ <?=$q['number']?><br><span><?=yh($area==='' && $q['id']==='s1q5'?'หมู่บ้าน / สาขาวิชา':$q['text'])?></span></th><?php endforeach;?></tr></thead><tbody><?php foreach($rows as $row):?><tr><td>#<?=yh($row['id'])?></td><td><?=yh(youthAreaLabel($row))?></td><?php foreach($columns as $q):?><td><?=yh(implode(' · ',$answersByResponse[$row['id']][$q['id']]??[])?:'-')?></td><?php endforeach;?></tr><?php endforeach;?></tbody></table></div><?php if(!$rows):?><div class="survey-empty">ยังไม่มีคำตอบตามตัวกรองนี้</div><?php endif;?>
<nav aria-label="หน้ารายการ">หน้า <?=$page?> / <?=$pages?> <?php if($page>1):?><a class="btn btn-default btn-sm" href="<?=yh(yurl(['page'=>$page-1]))?>">ก่อนหน้า</a><?php endif;?> <?php if($page<$pages):?><a class="btn btn-default btn-sm" href="<?=yh(yurl(['page'=>$page+1]))?>">ถัดไป</a><?php endif;?></nav></div></div>
</section></div><footer class="main-footer"><?php HtmlCore::getMenuFooter();?></footer></div><script src="plugins/jQuery/jQuery-2.1.4.min.js"></script><script src="bootstrap/js/bootstrap.min.js"></script><script src="dist/js/app.min.js"></script></body></html>
