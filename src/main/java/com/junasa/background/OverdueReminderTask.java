package com.junasa.background;

import com.junasa.DAO.User_Dao;
import com.junasa.bean.BorrowReminderInfo;
import com.junasa.utils.EmailSender;

import java.time.LocalDate;
import java.util.List;
import java.util.TimerTask;

public class OverdueReminderTask extends TimerTask { 

    @Override
    public void run() {
        System.out.println("Running OverdueReminderTask...");

        User_Dao dao = new User_Dao();
        List<BorrowReminderInfo> nearingDueList = dao.getNearingDueBorrows();

        if (nearingDueList.isEmpty()) {
            System.out.println("No borrowings nearing due date.");
        } else {
            System.out.println("Sending " + nearingDueList.size() + " reminder emails.");
            for (BorrowReminderInfo info : nearingDueList) {
                String subject = "Borrowing Due Soon Reminder";
                String message = "Hi " + info.getFname() + ",\n\n" +
                                 "Just a friendly reminder that your borrowed book \"" + info.getBookTitle() + "\" " +
                                 "is due soon on " + info.getReturnDate() + ".\n\n" + // Use the returnDate from the info object
                                 "Please make sure to return it on or before the due date to avoid penalties.\n\n" +
                                 "Best regards,\nThe LMS Team";

                EmailSender.sendEmail(info.getEmail(), subject, message);
            }
        }
    }
}