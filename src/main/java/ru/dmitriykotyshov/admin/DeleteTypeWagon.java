package ru.dmitriykotyshov.admin;

import ru.dmitriykotyshov.DAO.ConnectionDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by Дмитрий on 25.01.2018.
 */
public class DeleteTypeWagon extends HttpServlet {

    private final static String DELETE_TYPE_WAGON = "delete from type_wagon where type_wagon_id = %s";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        ConnectionDAO connectionDAO = new ConnectionDAO();
        String  typeWagonID= (req.getParameter("typeWagon"));
        String delete = String.format(DELETE_TYPE_WAGON, typeWagonID);
        connectionDAO.operatorDML(delete);
        connectionDAO.disconnect();

        req.getRequestDispatcher("typewagon").forward(req, resp);

    }
}