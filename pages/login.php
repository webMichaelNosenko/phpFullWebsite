<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Логин</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   <link rel="stylesheet" href="../css/login_style.css">
</head>

<body>
<div class="wrapper fadeInDown">
    <div id="formContent">
        <?php
            session_start();
            if ((isset($_SESSION["failed_login"])) && ($_SESSION["failed_login"] > 0))
                echo "<p>НЕВЕРНЫЙ ЛОГИН/ПАРОЛЬ</p>";
            session_destroy();
        ?>
        <form action="../php/login_script.php" method="post">
            <input type="text" id="login" class="fadeIn second" name="party_name" placeholder="Логин">
            <input type="text" id="password" class="fadeIn third" name="password" placeholder="Пароль">
            <br>
            <input type="checkbox" id="remember" name="remember">
            <label for="remember">Запомнить меня</label>
            <br>
            <input type="submit" class="fadeIn fourth" value="Войти">

        </form>
        <div id="formFooter">
            <a class="underlineHover" href="#">Забыли пароль?</a>
        </div>
    </div>
</div>
</body>
</html>
<?php
    include '../php/db_script.php';
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'login',
    'login_visits', $_SERVER['HTTP_USER_AGENT']);
?>