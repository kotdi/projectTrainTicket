<%@ page import="ru.dmitriykotyshov.trainticketobjects.RouteStation" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Дмитрий
  Date: 26.01.2018
  Time: 12:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>Administrator</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div id="header">
    <h1>Маршрут-станция</h1>
</div>
<div id="wrap">
    <div id="bodyAdmin">
        <p><a href="/admin">На главную администратора</a></p>
        <form action="/addRouteStation" method="get">
            <h3>Добавление:</h3>
            <table align="center">
                <tr>
                    <td><label for="routeID"><span class="bold">ID маршрута:</span> </label></td><td colspan="3"><input type="text" id="routeID" name="routeID"></td>
                </tr>
                <tr>
                    <td><label for="stationID"><span class="bold">ID станции:</span> </label></td><td colspan="3"><input type="text" id="stationID" name="stationID"></td>
                </tr>
                <tr>
                    <td><label for="orderStation"><span class="bold">Порядковый номер станции:</span> </label></td><td colspan="3"><input type="text" id="orderStation" name="orderStation"></td>
                </tr>
                <tr>
                    <td><label><span class="bold">Дата прибытия (YYYY-MM-DD HH:MM):</span> </label></td>
                    <td><input type="text" id="arrivalYear" name="arrivalYear"></td>
                    <td><input type="text" id="arrivalMonth" name="arrivalMonth"></td>
                    <td><input type="text" id="arrivalDay" name="arrivalDay"></td>
                    <td><input type="text" id="arrivalHour" name="arrivalHour"></td>
                    <td><input type="text" id="arrivalMinute" name="arrivalMinute"></td>
                </tr>
                <tr>
                    <td><label><span class="bold">Дата убытия (YYYY-MM-DD HH:MM):</span> </label></td>
                    <td><input type="text" id="departureYear" name="departureYear"></td>
                    <td><input type="text" id="departureMonth" name="departureMonth"></td>
                    <td><input type="text" id="departureDay" name="departureDay"></td>
                    <td><input type="text" id="departureHour" name="departureHour"></td>
                    <td><input type="text" id="departureMinute" name="departureMinute"></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2"><input type="submit" value="Добавить"></td>
                    <td></td>
                </tr>
            </table>
        </form>
        <form action="/delRouteStation" method="get">
            <h3>Удаление:</h3>
            <table align="center">
                <tr>
                    <td><label for="delRouteStation"><span class="bold">ID:</span> </label></td><td><input type="text" id="delRouteStation" name="routeStation"></td>
                    <td colspan="2"><input type="submit" value="Удалить"></td>
                </tr>
            </table>
        </form>
        <h3>Таблица ROUTE_STATION</h3>
        <table class="adminTable">
            <tr>
                <td>ROUTE_STATION_ID</td>
                <td>ROUTE_ID</td>
                <td>STATION_ID</td>
                <td>ORDER_STATION</td>
                <td>ARRIVAL_TIME</td>
                <td>DEPARTURE_TIME</td>
            </tr>
            <%
                List<RouteStation> routeStations = (List<RouteStation>) request.getAttribute("routeStations");
                StringBuilder writeRouteStations = new StringBuilder();
                for(RouteStation r: routeStations){
                    writeRouteStations.append("<tr>");
                    writeRouteStations.append("<td>"+r.getRouteStationId()+"</td>");
                    writeRouteStations.append("<td>"+r.getRouteId().getId()+"("+r.getRouteId().getNameRoute()+")</td>");
                    writeRouteStations.append("<td>"+r.getStationId().getId()+"("+r.getStationId().getNameStation()+")</td>");
                    writeRouteStations.append("<td>"+r.getOrderStation()+"</td>");
                    writeRouteStations.append("<td>"+r.getArrivalTime()+"</td>");
                    writeRouteStations.append("<td>"+r.getDepartureTime()+"</td></tr>");
                }
            %>
            <%=writeRouteStations%>
        </table>
    </div>
</div>
<div id="footer">
    <p>Дмитрий Котяшов 2к18<br>
        kotyshok@yandex.ru</p>
</div>
</body>
</html>