<?php
include 'db_script.php';
include 'upload_script.php';
session_start();

if ((isset($_POST['delete'])) && ($_POST['delete'] == 'delete')) {
    $name = $_POST['old_member_name'];
    $pname = $_SESSION["party_name"];
    $conn = get_connection();
    $sql = "DELETE FROM user_data.party_members WHERE party_name = '$pname' AND
                                                      name = '$name'";
    $delete_event = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $delete_event->execute();
    header("Location: ../pages/edit_members.php");
    die();
}

else if ((isset($_POST['redact'])) && ($_POST['redact'] == 'redact')) {
    $birth_date = $_POST["birth_date"];
    $work_time = $_POST["work_time"];
    $position = $_POST["position"];
    $payout = $_POST["payout"];
    $pname = $_SESSION["party_name"];
    $old_member_name = $_POST['old_member_name'];
    if (($payout > 100000000) || ($position == NULL) || ($work_time == NULL) || ($birth_date == NULL)) {
        $_SESSION["invalid_input"] = true;
        header("Location: ../pages/edit_members.php");
        die();
    }
    $birth_date = date('Y-m-d', strtotime($birth_date));
    $conn = get_connection();
    $sql = "UPDATE user_data.party_members 
            SET birth_date = '$birth_date',
                payout = '$payout',
                position = '$position',
                work_time = '$work_time'
            WHERE party_name = '$pname' AND
                  name = '$old_member_name'";
    $update_event = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $update_event->execute();
    if (isset($_POST['delete_file']))
        delete_avatar($old_member_name);
    else if (isset($_FILES["fileToUpload"])) {
        delete_avatar($old_member_name);
        upload_avatar($pname, $old_member_name);
    }
    header("Location: ../pages/edit_members.php");
    $conn = null;
    die();
}

else {
    $name = $_POST["name"];
    $birth_date = $_POST["birth_date"];
    $work_time = $_POST["work_time"];
    $position = $_POST["position"];
    $payout = $_POST["payout"];

    if ((strlen($name) > 40) || ($payout > 100000000) || ($position == NULL) || ($work_time == NULL) || ($birth_date == NULL)) {
        $_SESSION["invalid_input"] = true;
        header("Location: ../pages/edit_members.php");
    }

    if (isset($_SESSION["members"])) {
        for ($counter = 0; $counter < count($_SESSION['members']); $counter++) {
            if (in_array($name, $_SESSION["members"][$counter])) {
                $_SESSION["member_exists"] = true;
                header("Location: ../pages/edit_members.php");
                die();
            }
        }
    }

    $conn = get_connection();
    $birth_date = date('Y-m-d', strtotime($birth_date));
    $sql = "INSERT INTO user_data.party_members(party_name, name, birth_date, payout, position, work_time) 
            VALUES ('" . $_SESSION["party_name"] . "', '$name', '$birth_date', $payout, '$position', '$work_time')";
    $insert = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $insert->execute();

    if (isset($_FILES["fileToUpload"])) {
        upload_avatar($_SESSION["party_name"], $name);
    }

    $_SESSION["members"] = get_data_from_db($conn, $_SESSION["party_name"],
                                                        "SELECT name, birth_date, payout, position, work_time, image
                                                            FROM user_data.party_members 
                                                            WHERE party_name=:party_name");

    header("Location: ../pages/edit_members.php");
}