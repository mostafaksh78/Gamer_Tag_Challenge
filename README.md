# Gamer Tag  

A Flutter challenge showcasing scalable architecture, smooth animations, and efficient memory management, designed with a focus on UI/UX inspired by Apple's design principles.  

---

## **How to Run**  
1. Run `flutter pub get` to fetch dependencies.  
2. Execute the app using `flutter run`.  

---

## **Expectations**  
- [x] State Management  
- [x] Animation Fluidity  
- [x] Memory Usage  
- [x] Send and Remove Messages  
- [x] UI/UX  

---

## **Features and Implementation**  

### **1. State Management**  
I implemented **BLoC** for state management, chosen for its scalability and ability to handle complex states. While **Riverpod** could work well for smaller apps, I selected BLoC to demonstrate my engineering expertise. The app was designed with production-readiness in mind, addressing potential challenges like dynamic data loading during scrolling, buffer handling, and intricate workflows.  

### **2. Animation Fluidity**  
To deliver a smooth user experience, I used the **AnimatedList** widget for dynamic message insertion and removal. A **transition animation** was employed for message addition, while a **fade-out animation** handled message removal, ensuring seamless interactions.  

### **3. Memory Usage**  
To optimize memory usage, I implemented a **buffering mechanism** to manage data during scrolling. The buffer has a maximum size, and as new data loads, it dynamically removes data from the start or end based on scroll direction. This keeps memory usage within limits while maintaining a smooth scrolling experience.  

### **4. Sending and Removing Messages**  
Message sending and removal are managed through a **reactive data source** and a well-structured repository layer. This architecture ensures efficient and consistent operations across the app.  

### **5. UI/UX**  
The UI/UX design follows the Apple ecosystem, leveraging **Cupertino widgets** for a native iOS feel. However, for the AppBar, I customized the implementation using **Column** and **Row** widgets to accommodate the avatar image seamlessly.  

---

## **Software Architecture**  

### **CLEAN Architecture**  
The app employs the **CLEAN architecture** to bring it closer to a production-ready product.  

- **Data Layer**: Models the server and handles data retrieval.  
- **Domain Layer**: Converts server data into a format usable by the presentation layer.  
- **Presentation Layer**: Manages state, UI, and user interactions effectively.  



