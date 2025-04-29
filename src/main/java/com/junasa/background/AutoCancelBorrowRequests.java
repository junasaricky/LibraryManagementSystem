package com.junasa.background;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.BorrowCancelInfo;
import com.junasa.utils.EmailSender;

import java.util.List;
import java.util.TimerTask;

public class AutoCancelBorrowRequests extends TimerTask {

    @Override
    public void run() {
        System.out.println("Running AutoCancelBorrowRequests...");

        User_Dao dao = new User_Dao();
        List<BorrowCancelInfo> cancelledList = dao.autoCancelPendingBorrows();

        if (cancelledList.isEmpty()) {
            System.out.println("No pending borrow requests to cancel.");
        } else {
            System.out.println("Cancelled " + cancelledList.size() + " borrow requests.");
            for (BorrowCancelInfo info : cancelledList) {
                String subject = "Borrow Request Cancelled";
                String message = "Hi " + info.getFname() + ",\n\n" +
                                 "Unfortunately, your borrow request for the book \"" + info.getBookTitle() + "\" has been automatically cancelled " +
                                 "because it was not picked up within 3 days.\n\n" +
                                 "Feel free to request again if you're still interested!\n\n" +
                                 "Best regards,\nThe LMS Team";

                EmailSender.sendEmail(info.getEmail(), subject, message);
            }
        }
    }
}
