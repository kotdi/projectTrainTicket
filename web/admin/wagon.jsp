<%@ page import="ru.dmitriykotyshov.trainticketobjects.WagonDB" %>
<%@ page import="java.util.List" %>
<%@ page import="ru.dmitriykotyshov.trainticketobjects.TypeWagon" %>
<%@ page import="static ru.dmitriykotyshov.other.ValidAdmin.validationTrainAdmin" %>
<%@ page import="static ru.dmitriykotyshov.other.Message.insufficientRights" %><%--
  Created by IntelliJ IDEA.
  User: Дмитрий
  Date: 25.01.2018
  Time: 23:33
  To change this template use File | Settings | File Templates.
--%>
<%

    String login = (String) request.getSession().getAttribute("login");
    String password = (String) request.getSession().getAttribute("password");

    if (login == null || password == null){
        request.getRequestDispatcher("inputAdmin.jsp").forward(request, response);
    }
    Integer typeAdmin = Integer.valueOf((String) request.getSession().getAttribute("typeAdmin"));
    if (!validationTrainAdmin(typeAdmin))
        insufficientRights(request, response);

    List<TypeWagon> typeWagons = (List<TypeWagon>) request.getAttribute("typeWagons");

    StringBuilder wagonBuilder = new StringBuilder();
    for (int i=0; i<typeWagons.size(); i++){

        wagonBuilder.append("<option value=\""+typeWagons.get(i).getTypeWagonId()+"\">"+
                              typeWagons.get(i).getTypeName()+": "+
                                "кондиционер - "+(typeWagons.get(i).getAirCondition() == null? "нет " : "да ")+
                                "туалет - "+(typeWagons.get(i).getBioTiolet() == null? "нет " : "да ")+
                                "</option>\n");

    }




%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Administrator</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="../css/new_style.css">
    <script src="../js/admin/valid.wagon.js"></script>
    <script src="../js/admin/valid.delete.js"></script>
</head>
<body>
<div id="header">
    <h1>Вагоны</h1>
    <div id="myAdmin">Вы зашли как, <%=login%> <a href="/exitAdmin">Выйти</a></div>
</div>
<div id="wrap">
    <div id="bodyAdmin">
        <p><a href="/admin">На главную администратора</a></p>
        <form action="/addWagon" onsubmit="return validWagon()" method="get">
            <h3>Добавление:</h3>
            <table align="center">
                <tr>
                    <td><span id="erTrain"></span></td>
                </tr>
                <tr>
                    <td><label for="trainId"><span class="bold">ID поезда:</span> </label></td><td><input type="text" id="trainId" name="trainId"></td>
                </tr>
                <tr>
                    <td>
                        <span class="bold">Тип вагона:</span>
                    </td>
                    <td>
                        <select size="1" name="typeWagonId">
                            <option disabled>выберите тип</option>
                            <%=wagonBuilder%>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td><span id="erOrder"></span></td>
                </tr>
                <tr>
                    <td><label for="orderWagon"><span class="bold">Порядковый номер вагона:</span> </label></td><td><input type="text" id="orderWagon" name="orderWagon"></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Добавить"></td>
                </tr>
            </table>
        </form>
        <form action="/delWagon" onsubmit="return validDelete('delWagon')" method="get">
            <h3>Удаление:</h3>
            <table align="center">
                <tr>
                    <td colspan="3" id="mesDel"></td>
                </tr>
                <tr>
                    <td><label for="delWagon"><span class="bold">ID:</span> </label></td><td><input type="text" id="delWagon" name="wagon"></td>
                    <td colspan="2"><input type="submit" value="Удалить"></td>
                </tr>
            </table>
        </form>
        <h3>Таблица WAGON</h3>
        <table class="adminTable">
            <tr>
                <td>WAGON_ID</td>
                <td>TRAIN_ID</td>
                <td>TYPE_WAGON_ID</td>
                <td>ORDER_WAGON</td>
            </tr>
            <%
                List<WagonDB> wagons = (List<WagonDB>) request.getAttribute("wagons");
                StringBuilder writeWagons = new StringBuilder();
                for(WagonDB w: wagons){
                    writeWagons.append("<tr>");
                    writeWagons.append("<td>"+w.getWagonId()+"</td>");
                    writeWagons.append("<td>"+w.getTrain().getId()+"("+w.getTrain().getNumberTrain()+")</td>");
                    writeWagons.append("<td>"+w.getTypeWagon().getTypeWagonId()+"("+w.getTypeWagon().getTypeName()+")</td>");
                    writeWagons.append("<td>"+w.getOrderWagon()+"</td>");
                    writeWagons.append("</tr>");
                }
            %>
            <%=writeWagons%>
        </table>
    </div>
</div>
<div id="footer">
    <p>Дмитрий Котяшов 2к18<br>
        kotyshok@yandex.ru</p>
</div>
</body>
</html>
