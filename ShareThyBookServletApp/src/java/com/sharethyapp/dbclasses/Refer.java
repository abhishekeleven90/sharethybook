/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sharethyapp.dbclasses;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 *
 * @author abhishek
 */
public class Refer {

    public static void main(String args[]) {
        Connection c = null;
        try {
            Properties prop = new Properties();
            prop.load(new FileReader("global.prop"));
            String drivername = prop.getProperty("driver");
            String dburl=prop.getProperty("dburl");
            String uname=prop.getProperty("uname");
            String password=prop.getProperty("password");
            Class.forName(drivername);
            c = DriverManager
<<<<<<< HEAD
                    .getConnection("jdbc:postgresql://localhost:5432/library",
                            "postgres", "password");
=======
                    .getConnection(dburl,
                            uname, password);
            
            
            
            
>>>>>>> f6b8ef3f55fc724cad756bebb78de8826cd9f737
            c.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            System.exit(0);
        }
        System.out.println("Opened database successfully");
    }

}
