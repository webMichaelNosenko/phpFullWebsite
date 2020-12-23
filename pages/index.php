<?php
    include '../php/db_script.php';
    session_start();
    if (!isset($_SESSION['party_name'])) {
        header('Location: ../pages/unauth.html');
        session_destroy();
    }
    $members = $_SESSION["members"];
    $cities = $_SESSION["cities"];
    $events = $_SESSION["events"];
    $event_attendees = $_SESSION["event_attendees"];
    $conn = get_connection();
    $members = get_data_from_db($conn, $_SESSION["party_name"],
        "SELECT name, birth_date, payout, position, work_time, image
                                                            FROM user_data.party_members 
                                                            WHERE party_name=:party_name");
    $_SESSION["members"] = $members;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Панель управления</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js" integrity="sha384-LtrjvnR4Twt/qOuYxE721u19sVFLVSA4hf/rRt6PrZTmiPltdZcI7q7PXQBYTKyf" crossorigin="anonymous"></script>
    <script src="https://api-maps.yandex.ru/2.1/?apikey=d6871f7a-1378-4c9b-8531-c17d17299b0f&lang=ru_RU" type="text/javascript"></script>
    <script src="../js/yandex_map.js"></script>
</head>
<body>
<!--Партийная работа: список членов партии, список мероприятий, журнал учета выхода на мероприятие, список городов-->
<div class="container mt-3">
    <div style="display: flex; flex-direction: row;">
        <h2 style="flex-grow: 3">Панель управления партией</h2>
        <h2 style="flex-grow: 2"> <?php echo $_SESSION['party_name']?> </h2>
        <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="search.php">Поиск</a>
        <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="statistics.php">Статистика сайта</a>
        <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="../php/logout_script.php">Выход</a>
    </div>
    <br>
    <ul class="nav nav-pills nav-justified" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="pill" href="#members">Члены партии</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="pill" href="#events">Мероприятия</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="pill" href="#attendees">Учет выхода на мероприятие</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="pill" href="#cities">Список городов</a>
        </li>
    </ul><br>

    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane container active" id="members" >
            <a type="button" class="btn btn-primary" style="max-width: max-content;" href="edit_members.php">Редактировать</a>
            <br/><br/>
            <?php
                if ($members != "not found") {
                    for ($counter = 0; $counter < count($members); $counter++) {
                        echo "
                                <p>" . $members[$counter]["name"] . "</p>
                                <ul>
                                    <li>Дата рождения - " . $members[$counter]["birth_date"] . "</li>
                                    <li>Срок работы - " . $members[$counter]["work_time"] . "</li>
                                    <li>Должность - " . $members[$counter]["position"] . "</li>
                                    <li>Зарплата - " . $members[$counter]["payout"] . " рублей </li>
                                    <img class='img-thumbnail' style='max-width: 400px; max-height: 400px' src='../uploads/" . $members[$counter]["image"] . "'>
                                </ul>
                                <br><hr>
                             ";
                    }
                }
                else
                    echo "<p>No data for members of this party!</p>";
            ?>

        </div>

        <div class="tab-pane container fade" id="events">
            <a type="button" class="btn btn-primary" style="max-width: max-content;" href="edit_events.php">Редактировать</a>
            <br/><br/>
            <?php
            if ($events != "not found") {
                for ($counter = 0; $counter < count($events); $counter++) {
                    echo "<p id='". $events[$counter]["event_name"] ."'>" . $events[$counter]["event_name"] . "</p>
                        <ul>
                            <li>Время - " . $events[$counter]["time"] . "</li>
                            <li>Тема - " . $events[$counter]["theme"] . "</li>
                            <li>Город - " . $events[$counter]["city_name"] . "</li>
                            <br><br>
                            <li>Участники: <ul>";
                        for ($counter2 = 0; $counter2 < count($event_attendees); $counter2++) {
                            if ($event_attendees[$counter2]["event_name"] == $events[$counter]["event_name"]) {
                                echo "<li>" . $event_attendees[$counter2]["member_name"] . "</li>";

                            }
                        }
                        echo "
                            </ul>
                        </li>
                        </ul>
                        <br><hr>
                     ";
                }
            }
            else
                echo "<p>No data for events of this party!</p>";
            ?>
        </div>

        <div class="tab-pane container fade" id="attendees">
            <a type="button" class="btn btn-primary" style="max-width: max-content;" href="edit_attendance.php">Редактировать</a>
            <br/><br/>
            <p>Участники мероприятий</p>
            <?php
                    $no_attendees_flag = true;
                    echo "<ul>";
                    if (($event_attendees != "not found") && ($events != "not found")) {
                        for ($counter = 0; $counter < count($events); $counter++) {
                            echo "<li>" . $events[$counter]["event_name"] . "<ul>";
                            for ($counter2 = 0; $counter2 < count($event_attendees); $counter2++) {
                                if ($event_attendees[$counter2]["event_name"] == $events[$counter]["event_name"]) {
                                    echo "<li>" . $event_attendees[$counter2]["member_name"] . "</li>";
                                    $no_attendees_flag = false;
                                }
                            }
                            if ($no_attendees_flag)
                                echo "Члены партии не назначены на это событие";
                            echo "</ul></li><br><hr>";
                        }
                    }
                    else
                        echo "<p>No data for attendance of this party!</p>";
                    echo "</ul>";
            ?>
        </div>

        <div class="tab-pane container fade" id="cities">
            <a type="button" class="btn btn-primary" style="max-width: max-content;" href="edit_cities.php">Редактировать</a>
            <br/><br/>
            <?php
            if ($cities != "not found") {
                echo "<ul>";
                for ($counter = 0; $counter < count($cities); $counter++) {
                    echo "<li class='cityName'>" . $cities[$counter]["city_name"] . "</li>";
                }
                echo "</ul>";
            }
            else
                echo "<p>No data for cities of this party!</p>";
            ?>
            <div id="map" style="width: 600px; height: 400px"></div>
        </div>

    </div>
</div>
</body>
</html>
<?php
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'index',
    'index_visits', $_SERVER['HTTP_USER_AGENT']);
?>