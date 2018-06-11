/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Resources;

import java.sql.*;
import oracle.jdbc.*;

/**
 *
 * @author Gerardo
 */
public class Conn {
    
    private Connection conn=null;
    private Statement stm=null;
    private final String host="localhost"
            ,port="1521"
            ,user="testuser"
            ,pass="1234567g"
            ,SID="XE"
            //"jdbc:oracle:thin:@localhost:1521:XE"
            ,stringConn="jdbc:oracle:thin:@"+host+":"+port+":"+SID;
    
    public boolean abrir(){
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn=DriverManager.getConnection(stringConn,user,pass);
        } catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public void execute(String comando){
        try{
            stm=conn.createStatement();
            stm.execute(comando);
            stm.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public ResultSet executeQ(String comando){
        ResultSet rs=null;
        try{
            stm=conn.createStatement();
            rs=stm.executeQuery(comando);
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }
    
    public ResultSet getAll(){
        ResultSet rs=null;
        try{
            String usersSql = "{ ? := test_pkg.get_all; }";
            CallableStatement stmt = conn.prepareCall(usersSql);
            stmt.registerOutParameter(1,OracleTypes.CURSOR);
            stmt.execute();
            rs = ((OracleCallableStatement) stmt).getCursor(1);
        }catch(Exception e){
            e.printStackTrace();
        }
        return rs;
    }

    public void cerrar(){
        try{
            stm.close();
        }catch(Exception e){}
        try{
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
