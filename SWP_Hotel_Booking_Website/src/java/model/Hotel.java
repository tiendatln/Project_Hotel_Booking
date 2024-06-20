/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class Hotel {
    private int hotel_id;
    private String hotel_name, hotel_address, hotel_img, hotel_detail;
    private Account account;    

    public Hotel() {
    }

    public Hotel(int hotel_id, String hotel_name, String hotel_address, String hotel_img, String hotel_detail, Account account) {
        this.hotel_id = hotel_id;
        this.hotel_name = hotel_name;
        this.hotel_address = hotel_address;
        this.hotel_img = hotel_img;
        this.hotel_detail = hotel_detail;
        this.account = account;
    }

    public Hotel(int hotel_id) {
        this.hotel_id = hotel_id;
    }
    

    public int getHotel_id() {
        return hotel_id;
    }

    public void setHotel_id(int hotel_id) {
        this.hotel_id = hotel_id;
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

    public String getHotel_img() {
        return hotel_img;
    }

    public void setHotel_img(String hotel_img) {
        this.hotel_img = hotel_img;
    }

    public String getHotel_detail() {
        return hotel_detail;
    }

    public void setHotel_detail(String hotel_detail) {
        this.hotel_detail = hotel_detail;
    }

    public Account getAccount() {
        return account;
    }        

    public void setAccount(Account account) {
        this.account = account;
    }       
        
}
