<?php
include '../php/db_script.php';
session_start();
if (!isset($_SESSION['party_name'])) {
    header('Location: ../pages/unauth.html');
    session_destroy();
}
$conn = get_connection();
$cities = get_data_from_db($conn, $_SESSION["party_name"],
    "SELECT city_name    
         FROM user_data.city_owners 
         WHERE party_name=:party_name");
$_SESSION["cities"] = $cities;

$sql = 'SELECT city_name
        FROM user_data.cities';
$search_for_data = $conn->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
$search_for_data->execute();
$global_cities = $search_for_data->fetchAll();
$conn = null;
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
    </head>
    <body>
    <!--Партийная работа: список членов партии, список мероприятий, журнал учета выхода на мероприятие, список городов-->
    <div class="container mt-3">
        <div style="display: flex; flex-direction: row;">
            <h2 style="flex-grow: 3">Редактирование городов</h2>
            <h2 style="flex-grow: 2"><?php echo $_SESSION['party_name']?></h2>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="index.php">На главную</a>
            <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="../php/logout_script.php">Выход</a>
        </div>
        <br>
        <ul class="nav nav-pills nav-justified" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="pill" href="#cities">Города</a>
            </li>
        </ul><br>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane container active" id="cities" >
                <!--                    <button type="button" class="btn btn-primary" style="max-width: max-content;">Добавить</button>-->
                <div id="formContent">
                    <?php
                    if (isset($_SESSION["invalid_input"]) && ($_SESSION["invalid_input"])) {
                        echo "<p>Некорректные данные. Попробуйте еще раз</p>";
                        $_SESSION["invalid_input"] = false;
                    }
                    if (isset($_SESSION["city_exists"]) && ($_SESSION["city_exists"])) {
                        echo "<p>Такой город уже добавлен</p>";
                        $_SESSION["city_exists"] = false;
                    }
                    ?>
                    <form action="../php/edit_cities_script.php" method="post">
                        <select required type='text' id='city_name' name='city_name'>
                        <?php
                        if ($global_cities != "not found") {
                            for ($counter2 = 0; $counter2 < count($global_cities); $counter2++) {
                                echo "
                                <option value='" . $global_cities[$counter2]["city_name"] . "'>"
                                    . $global_cities[$counter2]['city_name'] . "</option>
                                ";
                            }
                        }
                        ?>
                        </select>
                        <span class="error" id="cityNameError" aria-live="polite"></span>
                        <br><br>
                        <input type="submit" class="btn btn-primary" style="max-width: max-content;" value="Добавить">
                    </form>
                </div>
                <br/><br/><br/><hr>
                <?php
                if ($cities != "not found") {
                    echo "<ul>";
                    for ($counter = 0; $counter < count($cities); $counter++) {
                        echo "
                            <li><p id='" . $cities[$counter]["city_name"] . "'>" . $cities[$counter]["city_name"] . "</p></li>
                            <form action='../php/edit_cities_script.php' method='post'>
                                <input hidden required readonly='readonly' type='text' id='old_city_name' name='old_city_name' value='" . $cities[$counter]["city_name"] . "'>
                                <input hidden required readonly='readonly' type='text' id='delete' name='delete' value='delete'>
                                <input type='submit' type='button' class='btn btn-primary' style='max-width: max-content; flex-grow: 1; margin-right: 15px' value='Удалить'>
                            </form>
                            <br>
                            <br><hr>";
                    }
                    echo "</ul>";
                }
                else
                    echo "<p>No data for cities of this party!</p>";
                ?>
            </div>
        </div>
    </div>
    <script src="../js/city_form_validation.js"></script>
    </body>
    </html>
<?php
if ((isset($_SERVER['REMOTE_ADDR'])) && (isset($_SERVER['REQUEST_TIME'])) && (isset($_SERVER['HTTP_REFERER'])) && (isset($_SERVER['HTTP_USER_AGENT'])))
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'edit_cities',
        'edit_cities_visits', $_SERVER['HTTP_USER_AGENT']);
?>