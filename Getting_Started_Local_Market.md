# Local Market — Getting Started

## 1. What We Are Building

**Local Market** is a hyperlocal shopping app.

The goal is simple:

> **Customers discover real products from nearby physical shops and choose either to visit the shop or receive the product at home.**

### Two buying options

```text
🏪 VISIT SHOP
Customer goes directly to the physical shop.
→ Show exact shop location
→ Open Google Maps
→ Customer buys from the shop

🛵 HOME DELIVERY
Customer orders from the shop.
→ Add delivery address
→ Default MVP delivery fee: ₹10
→ Seller prepares the order
→ Order is delivered
```

---

# 2. Build the MVP First

Do not start by building a huge e-commerce platform.

The first version only needs to prove this complete flow:

```text
SELLER
Create Account
     ↓
Create Shop
     ↓
Set Exact Location
     ↓
Take Product Photo
     ↓
Add Price + Stock
     ↓
Publish Product
     ↓
       ↓
BUYER
       ↓
Open Local Market
       ↓
Find Nearby Product
       ↓
Open Product
       ↓
See Shop
       ↓
 ┌───────────────┐
 │               │
 ▼               ▼
Visit Shop    Home Delivery
 │               │
 ▼               ▼
Google Maps    Address
                 ↓
               Order
```

If this works reliably, the MVP is successful.

---

# 3. Recommended Technology

For the first version:

## Mobile App

**Flutter**

Why:

- One codebase
- Android + iOS support
- Excellent camera support
- Location support
- Good UI performance
- Easy to create reusable components

## Backend

**Firebase**

Use:

```text
Firebase Authentication
Firebase Firestore
Firebase Storage
Firebase Cloud Messaging
Cloud Functions
```

## Maps

Use a map provider that supports:

- Shop coordinates
- Maps display
- Directions/navigation handoff

For the initial implementation, support Google Maps navigation from the shop page.

---

# 4. Project Setup

Create the project:

```bash
flutter create local_market
cd local_market
flutter run
```

First confirm that the default Flutter application runs successfully.

Do not install dozens of packages immediately.

Add dependencies only when a feature requires them.

---

# 5. Initial Project Structure

Use a feature-based structure:

```text
lib/
│
├── main.dart
│
├── core/
│   ├── constants/
│   ├── theme/
│   ├── routes/
│   ├── services/
│   └── utils/
│
├── models/
│   ├── user.dart
│   ├── shop.dart
│   ├── product.dart
│   ├── cart_item.dart
│   └── order.dart
│
├── features/
│   ├── splash/
│   ├── onboarding/
│   ├── auth/
│   ├── home/
│   ├── search/
│   ├── shops/
│   ├── products/
│   ├── cart/
│   ├── checkout/
│   ├── orders/
│   ├── seller/
│   └── profile/
│
└── widgets/
    ├── product_card.dart
    ├── shop_card.dart
    ├── primary_button.dart
    ├── location_row.dart
    └── order_status.dart
```

Keep reusable UI components separate from feature-specific screens.

---

# 6. First UI Design

Before connecting Firebase, create the UI using mock data.

Build these screens first:

```text
01 Splash
02 Location
03 Home
04 Search
05 Shop Details
06 Product Details
07 Seller Login
08 Seller Shop Setup
09 Add Product
10 Seller Dashboard
11 Cart
12 Checkout
13 Order Details
14 Profile
```

The app should already feel usable before the backend exists.

---

# 7. Brand Design

## App Name

**Local Market**

## Tagline

Recommended:

> **Your Local Shops. Your Choice.**

Alternative:

> **Real Products. Local Shops. Easy Buying.**

## Design personality

The interface should feel:

- Local
- Friendly
- Modern
- Trustworthy
- Simple
- Fast

Avoid making it look like a complicated large marketplace.

---

# 8. Color System

Start with a simple design system.

```text
Primary
→ Green

Secondary
→ Warm Orange/Yellow

Background
→ Light Neutral

Text
→ Dark Charcoal

Success
→ Green

Warning
→ Amber

Error
→ Red
```

Use one primary brand color consistently.

Do not use many competing colors.

---

# 9. Typography

Use a clean, highly readable font.

Recommended:

```text
Heading
Large + Bold

Section Title
Medium + Semi-bold

Body
Regular

Price
Bold

Button
Semi-bold
```

Prices should be visually prominent.

Example:

```text
Fresh Tomato

₹40/kg
```

---

# 10. Buyer Bottom Navigation

Use five main destinations:

```text
┌─────────────────────────────────┐
│                                 │
│           APP CONTENT           │
│                                 │
├─────────────────────────────────┤
│ 🏠      🔎      🛒      📦     👤 │
│ Home   Search   Cart   Orders Profile
└─────────────────────────────────┘
```

Do not put every feature into the bottom navigation.

---

# 11. Home Screen

The home screen should answer three questions immediately:

1. **Where am I?**
2. **What can I buy nearby?**
3. **Which shops are available?**

Recommended structure:

```text
📍 Beldanga                         🔔

Good evening 👋

🔎 Search products or shops...

Categories

🥦 Grocery
👕 Fashion
📱 Electronics
💊 Pharmacy
🥖 Bakery
🏠 Home

Nearby Shops

┌────────────────────────────┐
│ ABC Grocery                │
│ 🟢 Open                    │
│ 📍 0.5 km                  │
│ 🛵 Delivery available      │
└────────────────────────────┘

Popular Near You

[Product] [Product]
```

---

# 12. Location System

Location is a core feature.

At first launch:

```text
📍 Find shops near you

Local Market uses your location
to show nearby products and shops.

[Allow Location]

[Enter Location Manually]
```

If the user allows location:

```text
GPS
 ↓
latitude
longitude
 ↓
Nearby shops
 ↓
Nearby products
```

If permission is denied, allow manual location selection.

---

# 13. Seller Registration

Seller onboarding should be extremely simple.

## Step 1 — Phone

```text
Become a Seller

Mobile Number

[____________]

[Send OTP]
```

## Step 2 — Shop

```text
Create Your Shop

Shop Name
[ABC Grocery]

Category
[Grocery ▼]

Owner Name
[____________]

Phone
[____________]

[Continue]
```

## Step 3 — Location

This is critical.

```text
Set Your Shop Location

📍 Your shop location helps customers
find your physical store.

[Use Current Location]

[Select Location on Map]

Address
[________________]

[Confirm Location]
```

---

# 14. Shop Location Data

Do not save only the written address.

Store:

```text
shop_name
address
latitude
longitude
```

Example:

```text
shop_name: ABC Grocery
address: Market Road, Beldanga
latitude: 23.xxxxx
longitude: 88.xxxxx
```

The coordinates are what make accurate navigation possible.

---

# 15. Shop Location Confirmation

After selecting the location:

```text
✓ Location Confirmed

ABC Grocery

📍 Market Road
Beldanga

Coordinates saved.

[Save Shop]
```

Allow the seller to move the map pin manually if GPS is slightly inaccurate.

---

# 16. Add Product

This should be the fastest seller workflow in the app.

Seller taps:

```text
+ Add Product
```

Then:

```text
Add Product

┌──────────────────────────┐
│                          │
│          📸              │
│                          │
│   Take Product Photo     │
│                          │
└──────────────────────────┘

[Choose from Gallery]
```

Prefer camera capture because Local Market is based around real local products.

---

# 17. Product Details

After the photo:

```text
Product Name
[Fresh Tomato]

Price
[40]

Unit
[kg ▼]

Available Quantity
[25]

Category
[Vegetables]

Description
[Fresh local tomato]

Home Delivery
[ ON ]

[Publish Product]
```

The seller should be able to complete this in less than one minute.

---

# 18. Product Card

Use a consistent product card everywhere.

```text
┌─────────────────────────┐
│                         │
│      PRODUCT PHOTO      │
│                         │
├─────────────────────────┤
│ Fresh Tomato            │
│ ₹40/kg                  │
│                         │
│ ABC Grocery             │
│ 📍 0.5 km               │
│ 🟢 Available            │
└─────────────────────────┘
```

Optional:

```text
📸 Shop Photo
```

Only use "Original Photo" or similar wording when the system has a meaningful basis for that claim.

---

# 19. Product Details Screen

```text
[Large Product Photo]

Fresh Tomato

₹40/kg

🟢 Available

Sold by
ABC Grocery

📍 0.5 km away

────────────────────

Product Information

Fresh local tomato
Updated today

────────────────────

Buy From This Shop

🏪 Visit Shop
Go directly to the store

🛵 Home Delivery
Delivery ₹10

[Add to Cart]
```

The two buying options must be obvious.

---

# 20. Shop Details Screen

This is one of the most important screens.

```text
[Shop Photo]

ABC Grocery

✓ Verified Shop

🟢 Open
📍 0.5 km away

[Get Directions]

────────────────────

Shop Information

📍 Market Road, Beldanga
📞 Phone
⏰ 8:00 AM – 9:00 PM

────────────────────

Delivery

🛵 Home Delivery
₹10 delivery fee

────────────────────

Products

[Product]
[Product]
[Product]
```

---

# 21. Google Maps Flow

Buyer taps:

```text
[Get Directions]
```

The app should send the shop's:

```text
latitude
longitude
```

to the navigation/map flow.

Recommended experience:

```text
Local Market
     ↓
Shop Details
     ↓
Get Directions
     ↓
Map/navigation
     ↓
Shop
```

Do not ask the buyer to manually copy an address.

---

# 22. Visit Shop Flow

For a physical shop purchase:

```text
Product
 ↓
Visit Shop
 ↓
Shop Details
 ↓
Get Directions
 ↓
Customer visits shop
```

If the app supports reserving an item for pickup later:

```text
Reserve for Pickup
```

can be added in a later version.

Do not complicate the first MVP unless necessary.

---

# 23. Home Delivery Flow

```text
Product
 ↓
Add to Cart
 ↓
Checkout
 ↓
Home Delivery
 ↓
Delivery Address
 ↓
Product Total
+
₹10 Delivery
 ↓
Final Total
 ↓
Place Order
```

Example:

```text
Tomato × 2 kg       ₹80
Delivery             ₹10
────────────────────────
Total                ₹90
```

Keep the delivery fee configurable in the database even if the initial default is ₹10.

---

# 24. Cart Rule for MVP

Use:

> **One shop per cart.**

Example:

```text
ABC Grocery
 ├── Tomato
 ├── Rice
 └── Oil
```

Do not allow:

```text
ABC Grocery
+
Maa Store
+
New Market
```

inside one cart in version 1.

This keeps:

- Delivery
- Order processing
- Seller notifications
- Checkout

much simpler.

---

# 25. Checkout Screen

```text
Checkout

Purchase Method

◉ Home Delivery
  Delivery ₹10

○ Visit Shop
  No delivery fee

────────────────────

Items

Tomato × 2
₹80

────────────────────

Delivery
₹10

Total
₹90

[Place Order]
```

When Visit Shop is selected:

```text
Subtotal       ₹80
Delivery        ₹0
Total           ₹80

Pickup:
ABC Grocery

[Get Directions]

[Confirm]
```

---

# 26. Order Status

Use a simple status timeline.

## Home Delivery

```text
✓ Order Placed
      ↓
✓ Seller Accepted
      ↓
● Preparing
      ↓
○ Out for Delivery
      ↓
○ Delivered
```

## Shop Visit

```text
✓ Order Confirmed
      ↓
● Ready for Pickup
      ↓
○ Collected
```

---

# 27. Seller Dashboard

The seller dashboard should focus on actions.

```text
ABC Grocery 👋

Today's Orders
8

Today's Sales
₹2,450

────────────────────

Quick Actions

[+ Add Product]

[Products]

[Orders]

[Shop Profile]

────────────────────

Recent Orders

#LM1024
₹150
🛵 Delivery

[View]
```

---

# 28. Seller Product Management

Seller can:

```text
View Products
Edit Product
Change Price
Change Stock
Mark Out of Stock
Delete Product
Update Photo
```

Example:

```text
Fresh Tomato
₹40/kg

🟢 Available

[Edit]
```

---

# 29. Seller Order Management

New order:

```text
Order #LM1024

Tomato × 2
₹80

Delivery ₹10

Total ₹90

🛵 Home Delivery

[Accept]
[Reject]
```

After accepting:

```text
Order Accepted

[Start Preparing]
```

Then:

```text
Preparing

[Ready]
```

Then:

```text
Ready for Delivery

[Mark Out for Delivery]
```

Finally:

```text
[Mark Delivered]
```

For MVP, the seller can manage the delivery status.

---

# 30. Database

Start with these collections/tables:

```text
users
shops
products
orders
order_items
reviews
```

## users

```text
id
name
phone
role
created_at
```

## shops

```text
id
owner_id
shop_name
category
address
latitude
longitude
phone
opening_time
closing_time
delivery_enabled
delivery_fee
verified
created_at
```

## products

```text
id
shop_id
name
price
unit
stock_quantity
category
description
image_url
available
created_at
updated_at
```

## orders

```text
id
buyer_id
shop_id
order_type
subtotal
delivery_fee
total
status
delivery_address
delivery_latitude
delivery_longitude
created_at
```

## order_items

```text
id
order_id
product_id
quantity
price
```

---

# 31. Order Type

Use:

```text
VISIT_SHOP
HOME_DELIVERY
```

Do not infer this from other fields.

---

# 32. Order Status

Recommended enum:

```text
PENDING
ACCEPTED
PREPARING
READY
OUT_FOR_DELIVERY
DELIVERED
CANCELLED
REJECTED
```

For Visit Shop, use the statuses that make sense:

```text
PENDING
ACCEPTED
READY
COLLECTED
CANCELLED
```

---

# 33. Security

Important rules:

The client must never be trusted for:

- Final price
- Stock
- Delivery fee
- Seller ownership
- Order ownership

For example:

```text
Mobile app:
price = ₹10
```

but database says:

```text
price = ₹40
```

The backend must calculate the order using trusted database data.

---

# 34. Image Storage

Do not store large images directly inside the database.

Use:

```text
Phone Camera
      ↓
Compress/Resize
      ↓
Cloud Storage
      ↓
image_url
      ↓
Firestore product document
```

Store the URL and metadata in the product record.

---

# 35. Nearby Shops

Concept:

```text
User GPS
   ↓
Nearby shop query
   ↓
Distance
   ↓
Sort
   ↓
Show shops
```

Initial ranking:

```text
Available
↓
Nearby
↓
Open
↓
Recently updated
↓
Relevant search
```

For a production app, use a proper geospatial query/index rather than downloading every shop to the phone.

---

# 36. Search

Search should support:

```text
Product
Shop
Category
```

Example:

```text
Search: "rice"

ABC Grocery
₹60/kg
0.5 km

Maa Store
₹58/kg
0.8 km

New Market
₹62/kg
1.2 km
```

Filters:

```text
Nearest
Lowest Price
Available Now
Delivery Available
```

---

# 37. Loading, Empty and Error States

Every screen needs these states.

## Loading

```text
Finding nearby shops...
```

## Empty

```text
No shops found nearby.

Try another location.
```

## Error

```text
Something went wrong.

[Try Again]
```

## Offline

```text
You're offline.

Check your connection and try again.
```

## Location denied

```text
Location permission is disabled.

[Choose Location Manually]
```

---

# 38. Notification System

Buyer notifications:

```text
Order placed
Seller accepted
Order ready
Out for delivery
Delivered
```

Seller notifications:

```text
New order
Order cancelled
Low stock
```

Use push notifications.

---

# 39. Admin Panel

Admin should be able to:

```text
View users
View sellers
Verify shops
Suspend shops
Manage products
Review reports
View orders
Manage categories
```

Shop verification:

```text
PENDING
VERIFIED
REJECTED
SUSPENDED
```

Only verified shops should receive the Verified badge.

---

# 40. Development Phases

## Phase 1 — UI

Build all screens with fake data.

Goal:

> The entire app can be clicked through without a backend.

---

## Phase 2 — Authentication

Implement:

```text
Phone
 ↓
OTP
 ↓
Account
 ↓
Buyer/Seller role
```

---

## Phase 3 — Seller

Implement:

```text
Seller
 ↓
Shop
 ↓
Location
 ↓
Product photo
 ↓
Product
 ↓
Publish
```

---

## Phase 4 — Buyer

Implement:

```text
Location
 ↓
Nearby shops
 ↓
Products
 ↓
Search
 ↓
Shop details
```

---

## Phase 5 — Orders

Implement:

```text
Cart
 ↓
Visit Shop / Delivery
 ↓
Checkout
 ↓
Order
 ↓
Seller
 ↓
Status
```

---

## Phase 6 — Maps

Implement:

```text
Shop coordinates
 ↓
Get Directions
 ↓
Google Maps/navigation
```

---

## Phase 7 — Notifications

Implement:

```text
Seller ← New Order
Buyer ← Order Status
```

---

## Phase 8 — Admin

Implement:

```text
Seller verification
Shop verification
Product moderation
Order monitoring
Reports
```

---

# 41. First 7 Development Sessions

## Session 1 — Project + Design

Build:

- Flutter project
- Theme
- Colors
- Typography
- Navigation
- Splash

Goal:

> App launches with Local Market branding.

---

## Session 2 — Buyer Home

Build:

- Location header
- Search
- Categories
- Nearby shops
- Product cards
- Bottom navigation

Use mock data.

---

## Session 3 — Shop + Product

Build:

- Shop details
- Product details
- Shop location card
- Visit Shop button
- Delivery button

---

## Session 4 — Seller

Build:

- Seller login
- Seller dashboard
- Shop setup
- Location picker
- Add Product
- Product management

---

## Session 5 — Cart + Checkout

Build:

- Cart
- One-shop cart
- Visit Shop mode
- Home Delivery mode
- ₹10 delivery fee
- Address
- Total

---

## Session 6 — Backend

Connect:

- Authentication
- Firestore
- Storage
- Products
- Shops
- Orders

---

## Session 7 — Maps + Testing

Connect:

- Shop coordinates
- Map/navigation
- Location
- Test real shop
- Test real product
- Test real order

---

# 42. First Real-World Test

Do not wait until you have 100 features.

Take one real local shop.

Test:

### Seller

```text
Create seller account
 ↓
Create shop
 ↓
Set location
 ↓
Take photo
 ↓
Add product
 ↓
Publish
```

### Buyer

```text
Open app
 ↓
Find product
 ↓
Open shop
 ↓
Get directions
```

Then test:

```text
Home Delivery
 ↓
Address
 ↓
Order
 ↓
Seller accepts
 ↓
Order completed
```

If this works with one real shop, you have validated the core idea.

---

# 43. MVP Launch Target

Start small.

Recommended first test:

```text
1 Local Area
10–20 Shops
100–300 Products
Small Buyer Group
```

Do not immediately launch across an entire state.

The strength of Local Market is **local density**.

A small area with active shops is better than a huge area full of inactive listings.

---

# 44. Features to Add Later

After the MVP works:

```text
⭐ Reviews
❤️ Wishlist
🔔 Price alerts
🎟 Coupons
💳 Online payments
🛵 Delivery partner app
📍 Live delivery tracking
💬 Chat
🏷 Seller promotions
📊 Seller analytics
🤖 Smart recommendations
🛍 Multi-shop cart
```

Do not build these before the basic marketplace works.

---

# 45. Important Product Rules

### Rule 1

Every shop needs an exact location.

### Rule 2

Every product belongs to a shop.

### Rule 3

Every order belongs to one shop in the MVP.

### Rule 4

Every delivery order has a delivery fee.

### Rule 5

The initial default delivery fee is ₹10, but store it as a configurable value.

### Rule 6

The backend calculates final order totals.

### Rule 7

Only verified shops receive a Verified badge.

### Rule 8

Out-of-stock products cannot be ordered.

### Rule 9

The buyer should always know whether they are visiting the shop or requesting delivery.

### Rule 10

The UI should prioritize nearby real shops over generic marketplace content.

---

# 46. Definition of Done

The first MVP is complete when:

### Seller can

- [ ] Create an account
- [ ] Create a shop
- [ ] Set exact shop location
- [ ] Add shop information
- [ ] Take product photo
- [ ] Add product name
- [ ] Add price
- [ ] Add stock
- [ ] Publish product
- [ ] Receive order
- [ ] Update order status

### Buyer can

- [ ] Create an account
- [ ] Allow/select location
- [ ] Find nearby shops
- [ ] Search products
- [ ] See real product photos
- [ ] Open shop profile
- [ ] See exact shop location
- [ ] Open directions
- [ ] Choose Visit Shop
- [ ] Choose Home Delivery
- [ ] Enter delivery address
- [ ] See ₹10 delivery fee
- [ ] Place order
- [ ] Track order status

### Admin can

- [ ] View sellers
- [ ] Verify shops
- [ ] View products
- [ ] View orders
- [ ] Suspend problematic accounts

---

# 47. The First Milestone

Do not move to advanced features until this exact scenario works:

```text
Seller
  ↓
Creates "ABC Grocery"
  ↓
Sets exact shop location
  ↓
Takes photo of Tomato
  ↓
Sets ₹40/kg
  ↓
Publishes
       ↓
       ↓
Buyer opens Local Market
       ↓
Sees Tomato
       ↓
Sees "ABC Grocery"
       ↓
Sees "0.5 km"
       ↓
Chooses:
       ├── 🏪 Visit Shop
       │      ↓
       │   Get Directions
       │
       └── 🛵 Home Delivery
              ↓
           Address
              ↓
           ₹40 + ₹10
              ↓
           Place Order
              ↓
           Seller accepts
              ↓
           Order completed
```

**This is the first version of Local Market.**

Everything else comes after this works smoothly.
