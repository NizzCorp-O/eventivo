# 🎟️ Eventivo – Event Booking & Management App

Eventivo is a complete event booking system with **Admin** and **Participant** roles.  
The app allows Admin to create/manage events and Programs, while Participants can book tickets, make payments, and join events using QR verification.

---

## 🚀 Key Features

### 👨‍💼 Admin Features
- Create new events with:
  - Title, description  
  - Date & time  
  - Banner image  
  - Location  
- Add & manage programs under each event  
- View participant list and booking details  
- Real-time dashboard for event analytics  
- Scan participant tickets using built-in QR scanner  
- Validate ticket entries

---

### 🧑‍🤝‍🧑 Participant Features
- User login & profile  
- Browse all available events  
- View event details & programs  
- Book event tickets  
- Payment gateway integration  
- Generate a unique **QR ticket** after successful payment  
- See all booked events in “My Tickets”

---

## 🎫 Ticket QR System

- Each ticket generates a **unique QR code**  
- When Admin scans the QR:
  - If ticket is **valid & not used → allow entry**
  - If ticket is **already scanned → deny entry**
  - If ticket is **invalid → error message**
- Ensures **one ticket = one entry**  
- Scanning data stored in Firestore → secure, synced, and real-time

---

## 💳 Payment Features
- Integrated payment gateway (Razorpay / Stripe / PayPal)
- Secure checkout
- Auto-issue ticket after successful payment
- Payment status stored in database

---

## 🛠️ Technologies Used

### 🔹 **Frontend**
- Flutter  
- Dart  
- BLoC / Cubit for state management  
- Responsive UI  
- Custom widgets & animations  

### 🔹 **Backend**
- Firebase Firestore (Database)  
- Firebase Auth (Login & role access)  
- Firebase Storage (Images)  
 

### 🔹 **Third-Party Integrations**
- Razorpay / Stripe (Payment)  
- QR Code Generator  
- Mobile QR Scanner (Flutter plugins)

---

## 📦 Database Structure (Simple Overview)

