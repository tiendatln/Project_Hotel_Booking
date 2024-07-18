/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class updateRole {
    private int id;
    private String hotel_name;
    private String hotel_address;
    private String business_licens_img;
    private int status;
    private account account;

    public updateRole() {
    }

    public updateRole(int id, String hotel_name, String hotel_address, String business_licens_img, int status, account account) {
        this.id = id;
        this.hotel_name = hotel_name;
        this.hotel_address = hotel_address;
        this.business_licens_img = business_licens_img;
        this.status = status;
        this.account = account;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHotel_name() {
        return hotel_name;
    }

    public void setHotel_name(String hotel_name) {
        this.hotel_name = hotel_name;
    }

    public String getHotel_address() {
        return hotel_address;
    }

    public void setHotel_address(String hotel_address) {
        this.hotel_address = hotel_address;
    }

    public String getBusiness_licens_img() {
        return business_licens_img;
    }

    public void setBusiness_licens_img(String business_licens_img) {
        this.business_licens_img = business_licens_img;
    }

    public account getAccount() {
        return account;
    }

    public void setAccount(account account) {
        this.account = account;
    }
    
}
