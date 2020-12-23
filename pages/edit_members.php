<?php
    include '../php/db_script.php';
    session_start();
    if (!isset($_SESSION['party_name'])) {
        header('Location: ../pages/unauth.html');
        session_destroy();
    }
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
<!--        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">-->
<!--        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>-->
<!--        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>-->
<!--        <link rel="stylesheet" href="../css/login_style.css">-->
    </head>
    <body>
    <!--Партийная работа: список членов партии, список мероприятий, журнал учета выхода на мероприятие, список городов-->
        <div class="container mt-3">
            <div style="display: flex; flex-direction: row;">
                <h2 style="flex-grow: 3">Редактирование членов партии</h2>
                <h2 style="flex-grow: 2"><?php echo $_SESSION['party_name']?></h2>
                <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="index.php">На главную</a>
                <a type="button" class="btn btn-primary" style="max-width: max-content; flex-grow: 1; margin-right: 15px" href="../php/logout_script.php">Выход</a>
            </div>
            <br>
            <ul class="nav nav-pills nav-justified" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="pill" href="#members">Члены партии</a>
                </li>
            </ul><br>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane container active" id="members" >
<!--                    <button type="button" class="btn btn-primary" style="max-width: max-content;">Добавить</button>-->
                    <div id="formContent">
                        <?php
                            if (isset($_SESSION["invalid_input"]) && ($_SESSION["invalid_input"])) {
                                echo "<p>Некорректные данные. Попробуйте еще раз</p>";
                                $_SESSION["invalid_input"] = false;
                            }
                            if (isset($_SESSION["member_exists"]) && ($_SESSION["member_exists"])) {
                                echo "<p>Такой член партии уже существует</p>";
                                $_SESSION["member_exists"] = false;
                            }
                        ?>
                        <form action="../php/edit_members_script.php" method="post" enctype="multipart/form-data">
                            <input required maxlength="100" type="text" id="name" class="fadeIn second" name="name" placeholder="Имя">

                            <input required min="1900-01-01" max="2000-01-01" type="date" id="birth_date" class="fadeIn third" name="birth_date" placeholder="Дата рождения">

                            <input required type="text" id="work_time" name="work_time" placeholder="Срок работы (Х лет)">

                            <input required type="text" id="position" name="position" placeholder="Позиция">

                            <input required max="100000000" type="number" id="payout" name="payout" placeholder="Зарплата (в рублях)">
                            <br>
                            Картинка
                            <input type="file" name="fileToUpload" id="fileToUpload">

                            <span class="error" id="nameError" aria-live="polite"></span>
                            <span class="error" id="birthDateError" aria-live="polite"></span>
                            <span class="error" id="workTimeError" aria-live="polite"></span>
                            <span class="error" id="positionError" aria-live="polite"></span>
                            <span class="error" id="payoutError" aria-live="polite"></span>
                            <br><br>
                            <input type="submit" class="btn btn-primary" style="max-width: max-content;" value="Добавить">
                        </form>
                    </div>
                    <br/><br/><br/><hr>
                    <?php
                        if ($members != "not found") {
                            for ($counter = 0; $counter < count($members); $counter++) {
                                echo "
                                        <p id='" . $members[$counter]["name"] . "'>" . $members[$counter]["name"] . "</p>
                                        <form action='../php/edit_members_script.php' method='post'>
                                            <input hidden required readonly='readonly' type='text' id='name' name='name' value='" . $members[$counter]["name"] . "'>
                                            <input hidden required readonly='readonly' type='text' id='delete' name='delete' value='delete'>
                                            <input type='submit' type='button' class='btn btn-primary' style='max-width: max-content; flex-grow: 1; margin-right: 15px' value='Удалить'>
                                        </form>
                                        <ul>
                                            <li>Дата рождения - " . $members[$counter]["birth_date"] . "</li>
                                            <li>Срок работы - " . $members[$counter]["work_time"] . "</li>
                                            <li>Должность - " . $members[$counter]["position"] . "</li>
                                            <li>Зарплата - " . $members[$counter]["payout"] . " рублей </li>
                                            <img class='img-thumbnail' style='max-width: 400px; max-height: 400px' src='../uploads/" . $members[$counter]["image"] . "'>
                                        </ul>
                                        <form action='../php/edit_members_script.php' method='post' enctype='multipart/form-data'>
                
                                            <input required min='1900-01-01' max='2000-01-01' type='date' id='birth_date' class='fadeIn third' name='birth_date' placeholder='Дата рождения'>
                
                                            <input required type='text' id='work_time' name='work_time' placeholder='Срок работы (Х лет)'>
                
                                            <input required type='text' id='position' name='position' placeholder='Позиция'>
                
                                            <input required max='100000000' type='number' id='payout' name='payout' placeholder='Зарплата (в рублях)'>
                                            <br>
                                            Картинка
                                            <input type='file' name='fileToUpload' id='fileToUpload'>
                                            <input type='checkbox' id='delete_file' name='delete_file' value='delete_file'/>
                                            <label for='delete_file'>Удалить существующую картинку без загрузки новой</label>
                                            <input hidden required readonly='readonly' type='text' id='old_member_name' name='old_member_name' value='" . $members[$counter]["name"] . "'>
                                            <input hidden required readonly='readonly' type='text' id='redact' name='redact' value='redact'>
                                            <span class='error' id='nameError' aria-live='polite'></span>
                                            <span class='error' id='birthDateError' aria-live='polite'></span>
                                            <span class='error' id='workTimeError' aria-live='polite'></span>
                                            <span class='error' id='positionError' aria-live='polite'></span>
                                            <span class='error' id='payoutError' aria-live='polite'></span>
                                            <br><br>
                                            <input type='submit' class='btn btn-primary' style='max-width: max-content;' value='Редактировать'>
                                        </form>
                                        <br><hr>
                                     ";
                            }
                        }
                        else
                            echo "<p>No data for members of this party!</p>";
                    ?>
                </div>
            </div>
        </div>
        <script src="../js/member_form_validation.js"></script>
    </body>
    </html>
<?php
if ((isset($_SERVER['REMOTE_ADDR'])) && (isset($_SERVER['REQUEST_TIME'])) && (isset($_SERVER['HTTP_REFERER'])) && (isset($_SERVER['HTTP_USER_AGENT'])))
    log_statistics($_SERVER['REMOTE_ADDR'], $_SERVER['REQUEST_TIME'], $_SERVER['HTTP_REFERER'], 'edit_members',
    'edit_members_visits', $_SERVER['HTTP_USER_AGENT']);
?>