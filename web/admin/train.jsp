<%@ page import="ru.dmitriykotyshov.trainticketobjects.Train" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Дмитрий
  Date: 26.01.2018
  Time: 0:34
  To change this template use File | Settings | File Templates.
--%>
<%

    String login = (String) request.getSession().getAttribute("login");
    String password = (String) request.getSession().getAttribute("password");

    if (login == null || password == null){
        request.getRequestDispatcher("inputAdmin.jsp").forward(request, response);
    }



%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Administrator</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../css/new_style.css">
</head>
<body>
<div id="header">
    <h1>Поезда</h1>
    <div id="myAdmin">Вы зашли как, <%=login%> <a href="/exitAdmin">Выйти</a></div>
</div>
<div id="wrap">
    <div id="bodyAdmin">
        <p><a href="/admin">На главную администратора</a></p>
        <form action="/addTrain" method="get">
            <h3>Добавление:</h3>
            <table align="center">
                <tr>
                    <td><label for="numberTrain"><span class="bold">Номер поезда:</span> </label></td><td><input type="text" id="numberTrain" name="numberTrain"></td>
                </tr>
                <tr>
                    <td><label for="routeId"><span class="bold">ID маршрута:</span> </label></td><td><input type="text" id="routeId" name="routeId"></td>
                </tr>
                <tr>
                    <td><span class="bold">Экспрес: </span><input name="express" type="radio" value="1">Да</td>
                    <td><input name="express" type="radio" value="">Нет</td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Добавить"></td>
                </tr>
            </table>
        </form>
        <form action="/delTrain" method="get">
            <h3>Удаление:</h3>
            <table align="center">
                <tr>
                    <td><label for="delTrain"><span class="bold">ID:</span> </label></td><td><input type="text" id="delTrain" name="train"></td>
                    <td colspan="2"><input type="submit" value="Удалить"></td>
                </tr>
            </table>
        </form>
        <h3>Таблица TRAIN</h3>
        <table class="adminTable">
            <tr>
                <td>TRAIN_ID</td>
                <td>NUMBER_TRAIN</td>
                <td>ROUTE_ID</td>
                <td>EXPRESS</td>
            </tr>
            <%
                List<Train> trains = (List<Train>) request.getAttribute("trains");
                StringBuilder writeTrains = new StringBuilder();
                for(Train t: trains){
                    writeTrains.append("<tr>");
                    writeTrains.append("<td>"+t.getId()+"</td>");
                    writeTrains.append("<td>"+t.getNumberTrain()+"</td>");
                    writeTrains.append("<td>"+t.getRoute().getId()+"("+t.getRoute().getNameRoute()+"</td>");
                    writeTrains.append("<td>"+t.isExpress()+"</td></tr>");
                }
            %>
            <%=writeTrains%>
        </table>
    </div>
</div>
<div id="footer">
    <p>Дмитрий Котяшов 2к18<br>
        kotyshok@yandex.ru</p>
</div>
</body>
</html>
