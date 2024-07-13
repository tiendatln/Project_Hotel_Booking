/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class feedback {
    private int id;
    private String comment;
    private account account;
    private hotel hotel;
    

    /**
     *
     */
    public feedback() {
    }

    public feedback(int id, String comment, account account, hotel hotel) {
        this.id = id;
        this.comment = comment;
        this.account = account;
        this.hotel = hotel;
    }



    /**
     *
     * @param id
     * @param comment
     */
    public feedback( String comment) {
        
        this.comment = comment;
    }

    public account getAccount() {
        return account;
    }

    public void setAccount(account account) {
        this.account = account;
    }

    public hotel getHotel() {
        return hotel;
    }

    public void setHotel(hotel hotel) {
        this.hotel = hotel;
    }

    /**
     *
     * @return
     */
    public int getId() {
        return id;
    }

    /**
     *
     * @param id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     *
     * @return
     */
    public String getComment() {
        return comment;
    }

    /**
     *
     * @param comment
     */
    public void setComment(String comment) {
        this.comment = comment;
    }
    
}
