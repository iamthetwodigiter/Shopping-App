### **🛒 Shopping App (Flutter)**
A shopping application built with **Flutter**, following **Clean Architecture**. The app includes features like product browsing, cart management, and checkout with state management.

---

## **📌 Features**
### ✅ **Product Management**
- View product list with details
- Minimum order quantity validation  

### ✅ **Cart & Checkout**
- Add/remove items from cart  
- Quantity validation & price calculation  
- Order summary and checkout flow  

### ✅ **Other Features**
- API integration  
- State management using **Riverpod**  
- Clean Architecture with separate **data, domain, and presentation layers**  

---

## **🛠 Tech Stack**
- **Frontend**: Flutter (Dart)  
- **State Management**: Provider  
- **Backend API**: [DummyJSON](https://dummyjson.com/)  

---

## **📂 Project Structure**
```
lib/
│── features/
│   ├── auth/
│   ├── products/
│   │   ├── data/ (API calls, models, repository implementation)
│   │   ├── domain/ (entities, repository interface)
│   │   ├── presentation/ (UI, providers, state management)
│   ├── cart/
│── main.dart
```

---

## **🚀 Setup & Installation**
1️⃣ **Clone the repository**  
```bash
git clone https://github.com/iamthetwodigiter/Shopping-App.git
cd Shopping-App
```
2️⃣ **Install dependencies**  
```bash
flutter pub get
```
3️⃣ **Run the app**  
```bash
flutter run
```

---
