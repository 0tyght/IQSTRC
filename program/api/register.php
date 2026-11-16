<?php
include_once('../admin/indyEngine/dbControl.php');
include_once('../php/applicant_options.php');

$query = new DBControl();

$username = $_POST['eemm'] ?? '';
$password = $_POST['ppww'] ?? '';
$repassword = $_POST['reppww'] ?? '';
$img = $_POST['img'] ?? 'img/user.png';

$university_id = 0;
$faculty_id = 0;

$applicant_type = normalizeApplicantType($_POST['applicant_type'] ?? '');
$applicant_level = normalizeApplicantLevel(
    $applicant_type,
    $_POST['applicant_level'] ?? ''
);
$faculty_error = false;
$university_error = false;
$submitted_university = $_POST['university_id'] ?? '';
$submitted_faculty = $_POST['faculty_id'] ?? '';
if ($applicant_type === 'university' && $submitted_university !== '') {
    $university_value = filter_var($submitted_university, FILTER_VALIDATE_INT, array('options' => array('min_range' => 1)));
    if ($university_value === false) {
        $university_error = true;
    } else {
        $university_stmt = $query->connect->prepare('SELECT university_id FROM university WHERE university_id = ? LIMIT 1');
        $university_stmt->bind_param('i', $university_value);
        $university_stmt->execute();
        if (!$university_stmt->get_result()->fetch_assoc()) $university_error = true;
        else $university_id = (int)$university_value;
    }
}
if ($applicant_type === 'university' && $submitted_faculty !== '') {
    $faculty_value = filter_var($submitted_faculty, FILTER_VALIDATE_INT, array('options' => array('min_range' => 1)));
    if ($faculty_value === false) {
        $faculty_error = true;
    } else {
        $faculty_stmt = $query->connect->prepare('SELECT university_id FROM faculty WHERE faculty_id = ? LIMIT 1');
        $faculty_stmt->bind_param('i', $faculty_value);
        $faculty_stmt->execute();
        $faculty_row = $faculty_stmt->get_result()->fetch_assoc();
        if (!$faculty_row || !$university_id || (int)$faculty_row['university_id'] !== $university_id) {
            $faculty_error = true;
        } else {
            $faculty_id = (int)$faculty_value;
        }
    }
}

$birthday = $_POST['birthday'] ?? '';
$gender = $_POST['gender'] ?? '';

$pdpa1 = $_POST['pdpa1'] ?? 0;
$pdpa2 = $_POST['pdpa2'] ?? 0;
$pdpa3 = $_POST['pdpa3'] ?? 0;

if ($username == '') {
    echo '<script>$("#eemm").addClass("is-invalid");</script>';
} else {
    echo '<script>$("#eemm").removeClass("is-invalid");</script>';
}

if ($password == '') {
    echo '<script>$("#ppww").addClass("is-invalid");</script>';
} else {
    echo '<script>$("#ppww").removeClass("is-invalid");</script>';
}

if ($applicant_type == '') {
    echo '<script>$("#applicant_type").addClass("is-invalid");</script>';
} else {
    echo '<script>$("#applicant_type").removeClass("is-invalid");</script>';
}

if (
    $applicant_type != '' &&
    $applicant_type != 'general' &&
    $applicant_level == ''
) {
    echo '<script>$("#applicant_level").addClass("is-invalid");</script>';
} else {
    echo '<script>$("#applicant_level").removeClass("is-invalid");</script>';
}

if ($university_error) {
    echo '<script>$("#university_id").addClass("is-invalid");</script>';
    echo 'มหาวิทยาลัยที่เลือกไม่ถูกต้อง';
} else {
    echo '<script>$("#university_id").removeClass("is-invalid");</script>';
}
if ($faculty_error) {
    echo '<script>$("#faculty_id").addClass("is-invalid");</script>';
    echo 'คณะที่เลือกไม่ถูกต้อง กรุณาเลือกคณะจากรายการ';
} else {
    echo '<script>$("#faculty_id").removeClass("is-invalid");</script>';
}

if (
    $username != '' &&
    $password != '' &&
    $applicant_type != '' &&
    !$university_error &&
    !$faculty_error &&
    ($applicant_type == 'general' || $applicant_level != '')
) {
    $username_safe = mysqli_real_escape_string($query->connect, $username);
    $password_safe = mysqli_real_escape_string($query->connect, $password);
    $img_safe = mysqli_real_escape_string($query->connect, $img);
    $applicant_type_safe = mysqli_real_escape_string($query->connect, $applicant_type);
    $applicant_level_safe = mysqli_real_escape_string($query->connect, $applicant_level);
    $birthday_safe = mysqli_real_escape_string($query->connect, $birthday);
    $gender_safe = mysqli_real_escape_string($query->connect, $gender);

    $university_id_safe = intval($university_id);
    $faculty_id_safe = intval($faculty_id);
    $pdpa1_safe = intval($pdpa1);
    $pdpa2_safe = intval($pdpa2);
    $pdpa3_safe = intval($pdpa3);

    $chk = intval(
        $query->queryDB_to_string(
            'SELECT COUNT(user_id)
             FROM user
             WHERE user_username = "' . $username_safe . '"'
        )
    );

    if ($chk > 0) {
        echo 'มีชื่อผู้ใช้นี้แล้ว !';
        echo '<script>$("#eemm").addClass("is-invalid");</script>';
    } else {
        $sql = '
            INSERT INTO user (
                university_id,
                faculty_id,
                applicant_type,
                applicant_level,
                user_type,
                user_username,
                user_password,
                user_name,
                user_lastname,
                user_img,
                user_other_name,
                user_other_img,
                user_gender,
                user_birthday,
                user_phone,
                pdpa1,
                pdpa2,
                pdpa3
            ) VALUES (
                ' . $university_id_safe . ',
                ' . $faculty_id_safe . ',
                "' . $applicant_type_safe . '",
                "' . $applicant_level_safe . '",
                "member",
                "' . $username_safe . '",
                "' . $password_safe . '",
                "",
                "",
                "' . $img_safe . '",
                "",
                "",
                "' . $gender_safe . '",
                "' . $birthday_safe . '",
                "",
                ' . $pdpa1_safe . ',
                ' . $pdpa2_safe . ',
                ' . $pdpa3_safe . '
            )
        ';

        $result = $query->chkQuery($sql);

        if ($result === true) {
            $user_id = $query->getInsertID();

            echo '
                <script>
                    Swal.fire({
                        html: "สมัครสมาชิกเรียบร้อยแล้ว !",
                        type: "success",
                        confirmButtonText: " ตกลง ",
                        confirmButtonColor: "#3085d6"
                    }).then((result) => {
                        location.href = "login.php";
                    });
                </script>
            ';
        } else {
            echo '
                <script>
                    Swal.fire({
                        html: "ไม่สามารถสมัครสมาชิกได้<br><small>' . addslashes($result) . '</small>",
                        type: "error",
                        confirmButtonText: " ตกลง ",
                        confirmButtonColor: "#d33"
                    });
                </script>
            ';
        }
    }
} else {
    echo 'กรุณากรอกข้อมูลให้ครบ !';
}
?>
