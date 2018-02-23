package ru.dmitriykotyshov.admin;

import ru.dmitriykotyshov.DAO.DeleteDAO;
import ru.dmitriykotyshov.support.ServiceHelper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


/**
 * Created by Дмитрий on 13.01.2018.
 */
public class DeleteCity extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        DeleteDAO deleteDAO = ServiceHelper.getInstance("deleteDAO");

        String cityId = (req.getParameter("city"));

        deleteDAO.deleteCity(cityId);

        req.getRequestDispatcher("city").forward(req, resp);

    }
}
