<?php
include 'db_script.php';

function checkEmail($email) {
    $find1 = strpos($email, '@');
    $find2 = strpos($email, '.');
    return ($find1 !== false && $find2 !== false && $find2 > $find1);
}

$sql = '';
$party_name = $_POST['party_name'];
$password = $_POST['password'];
$admin_name = $_POST['admin_name'];
$email = $_POST['email'];

try {
    $conn = get_connection();
    if(($party_name == null) || (strlen($party_name) > 40) || (strlen($password) > 20) || ($password == null) ||
      ($admin_name == null) || (!checkEmail($email))) {
        session_start();
        $_SESSION["invalid_input"] = true;
        header('Location: ../pages/signup.php');
    }
    $sql = "SELECT id FROM user_data.credentials WHERE party_name=:party_name";
    $search_for_party = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
    $search_for_party->execute(array(':party_name'=>$party_name));
    $search_results = $search_for_party->fetchAll();
    if (empty($search_results)) {
        $password_hash = password_hash($password, PASSWORD_DEFAULT);
        $sql = "INSERT INTO user_data.credentials(party_name, password, email, admin_name) 
                VALUES ('$party_name', '$password_hash', '$email', '$admin_name')";
        $register_party = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
        $register_party->execute();
        setcookie("party_name", 'party'.$party_name.'cookie', time() + 3600, "/");
        pull_data_for_session($conn, $party_name);
        header('Location: ../pages/index.php');
    }
    else {
        session_start();
        $_SESSION["party_exists"] = true;
        header('Location: ../pages/signup.php');
    }
    // use exec() because no results are returned
} catch(PDOException $e) {
    echo $sql . "<br>" . $e->getMessage();
}

$conn = null;