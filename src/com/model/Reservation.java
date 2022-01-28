package com.model;

public class Reservation {

	private int id;
	private String guest_name;
	private int contact_no;
	private int nic;
	private String reserved_date;
	private int stayed_day;
	private String availability;
	private int room_no;
	private String room_category;
	private float room_price;
	
	public Reservation() {
		
	}
	
	public Reservation(int id, String guest_name, int contact_no, int nic, String reserved_date, int stayed_day,
			String availability, int room_no, String room_category, float room_price) {
		
		this.id = id;
		this.guest_name = guest_name;
		this.contact_no = contact_no;
		this.nic = nic;
		this.reserved_date = reserved_date;
		this.stayed_day = stayed_day;
		this.availability = availability;
		this.room_no = room_no;
		this.room_category = room_category;
		this.room_price = room_price;
	}
	
	public Reservation(String guest_name, int contact_no, String availability, int room_no, String room_category) {

		this.guest_name = guest_name;
		this.contact_no = contact_no;
		this.availability = availability;
		this.room_no = room_no;
		this.room_category = room_category;
	}



	public Reservation(String guest_name, int contact_no, int nic, String reserved_date, int stayed_day,
			String availability, int room_no, String room_category, float room_price) {
		
		this.guest_name = guest_name;
		this.contact_no = contact_no;
		this.nic = nic;
		this.reserved_date = reserved_date;
		this.stayed_day = stayed_day;
		this.availability = availability;
		this.room_no = room_no;
		this.room_category = room_category;
		this.room_price = room_price;
	}

	public Reservation(int id, String availability) {
		this.id = id; 
		this.availability = availability;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGuest_name() {
		return guest_name;
	}

	public void setGuest_name(String guest_name) {
		this.guest_name = guest_name;
	}

	public int getContact_no() {
		return contact_no;
	}

	public void setContact_no(int contact_no) {
		this.contact_no = contact_no;
	}

	public int getNic() {
		return nic;
	}

	public void setNic(int nic) {
		this.nic = nic;
	}

	public String getReserved_date() {
		return reserved_date;
	}

	public void setReserved_date(String reserved_date) {
		this.reserved_date = reserved_date;
	}

	public int getStayed_day() {
		return stayed_day;
	}

	public void setStayed_day(int stayed_day) {
		this.stayed_day = stayed_day;
	}

	public String getAvailability() {
		return availability;
	}

	public void setAvailability(String availability) {
		this.availability = availability;
	}

	public int getRoom_no() {
		return room_no;
	}

	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}

	public String getRoom_category() {
		return room_category;
	}

	public void setRoom_category(String room_category) {
		this.room_category = room_category;
	}

	public float getRoom_price() {
		return room_price;
	}

	public void setRoom_price(float room_price) {
		this.room_price = room_price;
	}

	@Override
	public String toString() {
		return "Reservation [id=" + id + ", guest_name=" + guest_name + ", contact_no=" + contact_no + ", nic=" + nic
				+ ", reserved_date=" + reserved_date + ", stayed_day=" + stayed_day + ", availability=" + availability
				+ ", room_no=" + room_no + ", room_category=" + room_category + ", room_price=" + room_price + "]";
	}
	
}
