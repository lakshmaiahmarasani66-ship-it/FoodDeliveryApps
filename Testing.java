package com.tap.utility;
import java.sql.Connection;

import com.tap.DAOImpl.UserDAOImpl;
//import com.tap.model.User;

public class Testing {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Connection connection=DBConnection.getConnection();
		if(connection!=null) {
			System.out.println("successfull");
		}
		else {
			System.out.println("not successfull");

			
		}
		
		

	}

}
