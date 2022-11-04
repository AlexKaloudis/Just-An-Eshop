/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/javafx/FXMLController.java to edit this template
 */
package mainpackage;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.stage.Stage;

/**
 * FXML Controller class
 *
 * @author Mike
 */
public class Scene2FXMLController implements Initializable {

    @FXML
    Button b_home,b_s1,b_s2;
    
     public void handleButtonHome() throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("menuFXML.fxml"));
        
        Stage window = (Stage) b_home.getScene().getWindow();
        window.setScene(new Scene(root,900,680));
    }
     
    public void handleButtonScene1() throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("scene1FXML.fxml"));
        
        Stage window = (Stage) b_s1.getScene().getWindow();
        window.setScene(new Scene(root,900,680));
    }
    
     public void handleButtonScene2() throws Exception{
        Parent root = FXMLLoader.load(getClass().getResource("scene2FXML.fxml"));
        
        Stage window = (Stage) b_s2.getScene().getWindow();
        window.setScene(new Scene(root,900,680));
    }
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    
    
}
