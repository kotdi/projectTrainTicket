package ru.dmitriykotyshov;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import ru.dmitriykotyshov.DAO.InsertDAO;
import ru.dmitriykotyshov.DAO.SelectDAO;
import ru.dmitriykotyshov.mail.Message;
import ru.dmitriykotyshov.other.MyDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Дмитрий on 26.01.2018.
 */
public class Buy extends HttpServlet {

    private final static Logger logger = Logger.getLogger(Buy.class);

    private final static String textMessage = "Здравствуйте, %s %s "+
            "Вы приобрели билет на нашем сайте, теперь вам его нужно оплатить по указанным реквезитам.";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("springContext.xml");

        SelectDAO selectDAO = applicationContext.getBean("SelectDAO", SelectDAO.class);
        InsertDAO insertDAO = applicationContext.getBean("InsertDAO", InsertDAO.class);



        logger.trace("buy ticket...");
        String firstName = req.getParameter("firstName");
        String middleName = req.getParameter("middleName");
        String lastName = req.getParameter("lastName");
        logger.trace("firstName - "+firstName);
        logger.trace("middleName - "+middleName);
        logger.trace("lastName - "+lastName);

        Integer year = Integer.valueOf(req.getParameter("year"));
        Integer month = Integer.valueOf(req.getParameter("month"));
        Integer day = Integer.valueOf(req.getParameter("day"));
        MyDate birthday = new MyDate(year, month, day);
        logger.trace("birthday - "+birthday);

        String document = req.getParameter("document");
        String docNumber = req.getParameter("docNumber");
        String gender = req.getParameter("gender");
        String email = req.getParameter("email");
        String telephone = req.getParameter("telephone");
        logger.trace("document - "+document);
        logger.trace("docNumber - "+docNumber);
        logger.trace("gender - "+gender);
        logger.trace("email - "+email);
        logger.trace("telephone - "+telephone);

        String route = req.getParameter("route");
        String numberTrain = req.getParameter("numberTrain");
        String orderWagon = req.getParameter("orderWagon");
        String firstRouteStation = req.getParameter("firstRouteStation");
        String secondRouteStation = req.getParameter("secondRouteStation");
        String place = req.getParameter("place");
        int price = Integer.valueOf(req.getParameter("price"));
        logger.trace("route - "+route);
        logger.trace("numberTrain - "+numberTrain);
        logger.trace("orderWagon - "+orderWagon);
        logger.trace("firstRouteStation - "+firstRouteStation);
        logger.trace("secondRouteStation - "+secondRouteStation);
        logger.trace("place - "+place);
        logger.trace("price - "+price);



        logger.trace("get customerId...");
        int customerId = selectDAO.getCustomerId(docNumber, document);
        if (customerId == 0) {
            logger.trace("customerId = 0, (new)insertCustomer");
            insertDAO.insertCustomer(firstName, middleName, lastName, birthday, gender, document, docNumber, email, telephone);
            customerId = selectDAO.getCustomerId(docNumber, document);
        }
        logger.trace("customerId = "+customerId);


        String date = new SimpleDateFormat("YYYY-MM-dd").format(new Date());
        logger.trace("todays date - "+date);


        int firstRouteStationId = selectDAO.getRouteStationId(route, firstRouteStation, 1);
        logger.trace("firstRouteStationId - "+firstRouteStationId);
        int secondRouteStationId = selectDAO.getRouteStationId(route, secondRouteStation, 2);
        logger.trace("secondRouteStationId - "+secondRouteStationId);
        int wagonId = selectDAO.getWagonId(numberTrain, orderWagon);
        logger.trace("wagonId - "+wagonId);


        logger.trace("insert ticket...");
        insertDAO.insertTicket(customerId, wagonId, place, date, firstRouteStationId, secondRouteStationId, price);


        String text = String.format(textMessage, firstName, middleName);
        logger.trace("text message - "+text);



        Message message = new Message(email, "Train&Ticket", text);
        message.sendMessage();

        req.setAttribute("firstName", firstName);
        req.setAttribute("middleName", middleName);
        req.getRequestDispatcher("buy.jsp").forward(req, resp);

    }

}
