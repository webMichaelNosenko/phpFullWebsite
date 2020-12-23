<?php
// TODO добавить КУДА произошел переход, фильтровать переходы от локалхоста?
include '../php/db_script.php';
session_start();
if (!isset($_SESSION['party_name'])) {
    header('Location: ../pages/unauth.html');
}
$visits = get_visits();
$redirects = get_redirects();
$registered_users = count_registered_users();
$unique_visits = count_unique_visits();

echo '
    <head>
        <meta charset="UTF-8">
        <title>Панель управления</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>
    </head>
    <body>
    <!--Партийная работа: список членов партии, список мероприятий, журнал учета выхода на мероприятие, список городов-->
        <div class="container mt-3">
            <div style="display: flex; flex-direction: row;">
                <h2 style="flex-grow: 3">Статистика посещения сайта</h2>
                <h2 style="flex-grow: 2"></h2>
                <a type="button" class="btn btn-primary" 
                                 style="max-width: max-content; flex-grow: 1; margin-right: 15px" 
                                 href="index.php">Панель управления</a>
                <a type="button" class="btn btn-primary" 
                                 style="max-width: max-content; flex-grow: 1; margin-right: 15px" 
                                 href="../php/logout_script.php">Выход</a>
            </div>
            <br>
            <ul class="nav nav-pills nav-justified" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="pill" href="#views">Просмотры</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#uniquevisits">Уникальные посетители</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="pill" href="#visitsources">Источники переходов</a>
                </li>
            </ul><br>
        
        <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane container active" id="views">
                    <ul>
                        <li>Просмотры страницы регистрации: ' . $visits[0]["signup_visits"] .'</li>
                        <li>Просмотры страницы логина: '. $visits[0]["login_visits"] .'</li>
                        <li>Просмотры главной страницы: '. $visits[0]["index_visits"] .' </li>
                    </ul>
                </div>
            
                <div class="tab-pane container" id="uniquevisits">
                    <ul>
                        <li>Уникальные ip адреса посетителей главной страницы: '. $unique_visits[0] .'</li>
                        <li>Количество зарегистрированных пользователей: '. $registered_users[0] .'</li>
                    </ul>
                </div>
                <div class="tab-pane container" id="visitsources">
                    Источники переходов
                    <ul>
                    ';
                    for ($counter = 0; $counter < count($redirects); $counter++) {
                        echo '<li>' . $redirects[$counter]["redirect_source"] . ' -> '
                             . $redirects[$counter]["redirect_target"] . ' --- '
                             . $redirects[$counter]["ip_addr"] . ' , '
                             . $redirects[$counter]["request_time"] . '</li>';
                    }
echo '
                    </ul>
                </div>
            </div>
        </div>
    </body>
';
