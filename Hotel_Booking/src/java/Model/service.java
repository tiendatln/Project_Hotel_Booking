/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class service {
    private int service_id;
    private String service_name;
    private String service_description;
    private long service_price;
    
    public service() {
    }

    public service(int service_id,String service_name, String service_description, long service_price) {
        this.service_id = service_id;
        this.service_name = service_name;
        this.service_description = service_description;
        this.service_price = service_price;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public String getService_description() {
        return service_description;
    }

    public void setService_description(String service_description) {
        this.service_description = service_description;
    }

    public long getService_price() {
        return service_price;
    }

    public void setService_price(long service_price) {
        this.service_price = service_price;
    }
    
}
