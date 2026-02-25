# 🛍️ Beespoke AI Personalized Store

## 📌 Approach
The app is designed as a **personalized e-commerce browsing experience**, allowing users to:  
- Explore products  
- Like items  
- Filter by category  
- View browsing history  

The focus was on creating a **smooth and intuitive shopping flow**, similar to real-world e-commerce platforms.  

The UI is built using a **grid-based product feed** with:  
- Category filtering  
- Search functionality  
- Dedicated screens for liked items and browsing history  

---

## ⚙️ State Management Choice
**Provider** was used for state management because:  
- Lightweight and scalable  
- Easy separation of UI and business logic  
- Efficient rebuild handling  

**Providers used:**  
- `ProductProvider` → API data  
- `PreferenceProvider` → likes/dislikes  
- `HistoryProvider` → browsing history  

---

## 💾 Data Persistence Method
**Hive** was used for local persistence because:  
- Fast and lightweight  
- Offline support  
- Simple key-value storage  
- Perfect for storing user preferences and browsing history  

---

## 🚀 What I Would Improve With More Time
- AI-based product recommendation engine  
- Cart and checkout flow  
- Skeleton loading animations  
- Dark mode  
- Firebase sync for multi-device persistence  
- Better product detail animations  
- Pagination and caching optimization  

---

## ⏱️ Approximate Time Spent
I have spent **approximately 8–10 hours** developing and testing this app.
