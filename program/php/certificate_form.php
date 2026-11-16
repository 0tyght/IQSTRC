<?php
$firstName = htmlspecialchars($user['user_name'] ?? '', ENT_QUOTES, 'UTF-8');
$lastName = htmlspecialchars($user['user_lastname'] ?? '', ENT_QUOTES, 'UTF-8');
?>
<form class="certificate-form" method="post" action="<?= htmlspecialchars($certificateDownload, ENT_QUOTES, 'UTF-8') ?>">
    <label for="certificate-first">ชื่อ</label>
    <input id="certificate-first" name="first_name" type="text" maxlength="80" autocomplete="given-name" required value="<?= $firstName ?>">
    <label for="certificate-last">นามสกุล</label>
    <input id="certificate-last" name="last_name" type="text" maxlength="80" autocomplete="family-name" required value="<?= $lastName ?>">
    <button class="bt_big bg-dark" type="submit"><i class="fa fa-download pr-2"></i>ดาวน์โหลดเกียรติบัตร</button>
</form>
<style>
.certificate-form { display:grid; gap:8px; margin-top:20px; text-align:left; }
.certificate-form label { margin:0; font-weight:600; }
.certificate-form input { box-sizing:border-box; width:100%; min-width:0; min-height:48px; padding:10px 12px; border:1px solid #aebfc2; border-radius:6px; background:#fff; font-size:16px; }
.certificate-form button { margin-top:8px; width:100%; }
.certificate_name { overflow-wrap:anywhere; }
</style>
<script>
(function () {
    var first = document.getElementById('certificate-first');
    var last = document.getElementById('certificate-last');
    var preview = document.querySelector('.certificate_name');
    function update() { preview.textContent = [first.value.trim(), last.value.trim()].filter(Boolean).join(' '); }
    first.addEventListener('input', update);
    last.addEventListener('input', update);
    update();
})();
</script>
