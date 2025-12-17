package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EtatCheque {
    private int id_etat;
    private String nameEtat; 

    public int getId_etat() {
        return id_etat;
    }
    public String getNameEtat() {
        return nameEtat;
    }
    public void setId_etat(int id_etat) {
        this.id_etat = id_etat;
    }
    public void setNameEtat(String nameEtat) {
        this.nameEtat = nameEtat;
    }
    public EtatCheque(){
        
    }
    public EtatCheque(int id, String etat){
        setId_etat(id);
        setNameEtat(etat);
    }
    
  
    }
    
