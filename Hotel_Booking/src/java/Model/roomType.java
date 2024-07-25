/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author tiend
 */
public class roomType {
    private int room_type_id;
    private String name_type;


    /**
     *
     */
    public roomType() {
    }

    public roomType(int room_type_id) {
        this.room_type_id = room_type_id;
    }

    /**
     *
     * @param room_type_id
     * @param name_type
     */
    public roomType(int room_type_id, String name_type) {
        this.room_type_id = room_type_id;
        this.name_type = name_type;
    }



    /**
     *
     * @return
     */
    public int getRoom_type_id() {
        return room_type_id;
    }

    /**
     *
     * @param room_type_id
     */
    public void setRoom_type_id(int room_type_id) {
        this.room_type_id = room_type_id;
    }

    /**
     *
     * @return
     */
    public String getName_type() {
        return name_type;
    }

    /**
     *
     * @param name_type
     */
    public void setName_type(String name_type) {
        this.name_type = name_type;
    }



    
}
