/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Ngo Hong Hai - CE171752
 */
public class Account {
    String username, password; 
    boolean is_owner, is_manager, is_admin, ban_status;
    int report_count;
    String email, name;
    int age;
    String phone, id_number;

    public Account() {
    }

    public Account(String username, String password, boolean is_owner, boolean is_manager, boolean is_admin, boolean ban_status, int report_count, String email, String name, int age, String phone, String id_number) {
        this.username = username;
        this.password = password;
        this.is_owner = is_owner;
        this.is_manager = is_manager;
        this.is_admin = is_admin;
        this.ban_status = ban_status;
        this.report_count = report_count;
        this.email = email;
        this.name = name;
        this.age = age;
        this.phone = phone;
        this.id_number = id_number;
    }

    public Account(String username) {
        this.username = username;
    }
    

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isIs_owner() {
        return is_owner;
    }

    public void setIs_owner(boolean is_owner) {
        this.is_owner = is_owner;
    }

    public boolean isIs_manager() {
        return is_manager;
    }

    public void setIs_manager(boolean is_manager) {
        this.is_manager = is_manager;
    }

    public boolean isIs_admin() {
        return is_admin;
    }

    public void setIs_admin(boolean is_admin) {
        this.is_admin = is_admin;
    }

    public boolean isBan_status() {
        return ban_status;
    }

    public void setBan_status(boolean ban_status) {
        this.ban_status = ban_status;
    }

    public int getReport_count() {
        return report_count;
    }

    public void setReport_count(int report_count) {
        this.report_count = report_count;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getId_number() {
        return id_number;
    }

    public void setId_number(String id_number) {
        this.id_number = id_number;
    }
    
    
}
