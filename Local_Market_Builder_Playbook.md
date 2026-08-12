# Local Market — Builder Playbook

## 1. Product Vision

**Local Market** is a hyperlocal shopping app that connects buyers with nearby physical shops.

The key promise:

> **See real products from real local shops, then either visit the shop yourself or order home delivery.**

The app should feel simpler than a large e-commerce marketplace. The focus is **nearby stores, authentic product photos, transparent shop location, simple ordering, and local convenience**.

### Primary buyer choices

Every eligible product/shop should support two clear purchase paths:

1. **Visit Shop**
   - Buyer goes directly to the physical shop.
   - Show exact shop location.
   - Open the location in Google Maps.
   - Show shop hours and contact information.

2. **Home Delivery**
   - Buyer orders from the shop.
   - Start with a simple fixed **₹10 delivery charge** for the MVP.
   - Show product price + delivery fee + total before confirmation.

---

# 2. MVP Scope

Build the first version around four areas:

```text
LOCAL MARKET
│
├── Buyer App
│   ├── Home
│   ├── Search
│   ├── Categories
│   ├── Nearby Shops
│   ├── Product Details
│   ├── Shop Details
│   ├── Cart
│   ├── Checkout
│   └── Orders
│
├── Seller App
│   ├── Seller Registration
│   ├── Shop Setup
│   ├── Add Product
│   ├── My Products
│   ├── Orders
│   └── Shop Dashboard
│
├── Delivery Flow
│   ├── Delivery Address
│   ├── Delivery Order
│   └── Order Status
│
└── Admin
    ├── Users
    ├── Sellers
    ├── Shops
    ├── Products
    └── Orders
```

Do **not** start by building every possible feature. Build the smallest complete shopping journey first.

---

# 3. Core User Journeys

## Buyer Journey A — Visit Shop

```text
Open App
   ↓
Allow Location
   ↓
Nearby Products / Shops
   ↓
Open Product
   ↓
Open Shop
   ↓
View Shop Location
   ↓
"Get Directions"
   ↓
Google Maps
   ↓
Visit Physical Shop
```

## Buyer Journey B — Home Delivery

```text
Open App
   ↓
Find Product
   ↓
Select Product
   ↓
Add to Cart
   ↓
Choose "Home Delivery"
   ↓
Confirm Address
   ↓
Product Price + ₹10 Delivery
   ↓
Place Order
   ↓
Seller Accepts
   ↓
Preparing
   ↓
Out for Delivery
   ↓
Delivered
```

## Seller Journey

```text
Create Seller Account
        ↓
Create Shop Profile
        ↓
Set Exact Shop Location
        ↓
Add Product
        ↓
Take Original Product Photo
        ↓
Enter Name + Price + Stock
        ↓
Publish
        ↓
Receive Orders
        ↓
Accept / Reject
        ↓
Prepare Order
        ↓
Complete Order
```

---

# 4. Design Principles

The UI should follow five principles:

### 4.1 Local first

Always prioritize:

- Distance
- Shop name
- Availability
- Price
- Shop location
- Delivery availability

### 4.2 Real photos

Sellers should be encouraged to photograph the actual product.

The primary product-upload action should be:

> **Take Product Photo**

rather than making sellers search for stock images.

### 4.3 Two purchase choices

Do not hide the two modes.

Use two highly visible actions:

```text
┌─────────────────────────────┐
│  🏪 Visit Shop              │
│  Buy directly from the shop│
└─────────────────────────────┘

┌─────────────────────────────┐
│  🛵 Home Delivery            │
│  Delivery fee ₹10            │
└─────────────────────────────┘
```

### 4.4 Minimal checkout

The buyer should not have to navigate through many screens.

### 4.5 Trust

Show:

- Verified shop
- Real product photo
- Shop address
- Distance
- Opening hours
- Seller/shop name
- Order status

---

# 5. Recommended Visual Design

## Brand personality

Local Market should feel:

- Friendly
- Local
- Modern
- Reliable
- Simple
- Fast

Avoid making it look like a complicated corporate marketplace.

## Suggested visual language

Use:

- Large product photographs
- Rounded cards
- Soft shadows
- Clear typography
- Large touch targets
- Simple icons
- Bottom navigation
- Plenty of whitespace

## Color direction

Use one strong primary brand color and neutral backgrounds.

Suggested direction:

- Primary: Green
- Secondary: warm yellow/orange
- Background: very light neutral
- Text: dark charcoal
- Success: green
- Warning: amber
- Error: red

Do not overload the interface with many colors.

---

# 6. Buyer App — Screen-by-Screen UI

## Screen 1 — Splash

Display:

```text
       LOCAL
      MARKET

  Nearby shops. Real products.
```

Then automatically move to onboarding/home.

---

# 7. First Launch / Location Permission

Location is important because Local Market is hyperlocal.

Screen:

```text
📍 Find shops near you

Allow Local Market to use your
location to show nearby shops
and products.

[Allow Location]

[Enter Location Manually]
```

Never make location permission feel mysterious.

Explain why it is required.

---

# 8. Home Screen

Recommended layout:

```text
┌──────────────────────────────────┐
│ 📍 Your Location              🔔 │
│ Beldanga                         │
├──────────────────────────────────┤
│ 🔎 Search products or shops...   │
├──────────────────────────────────┤
│                                  │
│ Categories                       │
│                                  │
│ 🥦 Grocery   👕 Fashion          │
│ 💊 Pharmacy  📱 Electronics      │
│ 🥖 Bakery    🏠 Home             │
│                                  │
├──────────────────────────────────┤
│ Nearby Shops                     │
│                                  │
│ [Shop Card]                      │
│ [Shop Card]                      │
│ [Shop Card]                      │
│                                  │
├──────────────────────────────────┤
│ Popular Near You                 │
│                                  │
│ [Product] [Product]              │
│                                  │
├──────────────────────────────────┤
│ Home     Search     Orders       │
│                  Cart     Profile │
└──────────────────────────────────┘
```

## Home card priorities

A shop card should show:

```text
Shop photo
Shop name
Category
Distance
Open/Closed
Delivery available
```

Example:

```text
ABC Grocery
🟢 Open
📍 0.8 km
🛵 Delivery available
```

---

# 9. Search

Search should support:

- Product name
- Shop name
- Category

Example:

```text
🔎 Search "rice"
```

Results:

```text
Rice

₹60/kg
ABC Grocery
📍 0.8 km

₹58/kg
Maa Store
📍 1.1 km

₹62/kg
New Market Store
📍 1.5 km
```

Sort options:

- Nearest
- Lowest price
- Available now

---

# 10. Product Card

Every product card should contain:

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
│ 📍 800 m                │
│ 🟢 Available            │
│                         │
│ [View]                  │
└─────────────────────────┘
```

Optional badge:

> 📸 Original Shop Photo

This badge should only be shown when the image meets the app's original-photo rule.

---

# 11. Product Details

Recommended layout:

```text
[Large Product Image]

Fresh Tomato

₹40/kg

🟢 Available

Sold by:
ABC Grocery

📍 800 m away

────────────────────

Product information

Fresh local tomato
Updated today

────────────────────

Purchase method

🏪 Visit Shop
Go to the store

🛵 Home Delivery
Delivery ₹10

────────────────────

[Add to Cart]
```

For a single-product immediate purchase, allow:

```text
[Visit Shop]
[Order Delivery]
```

---

# 12. Shop Details Screen

This is one of the most important screens in the entire product.

```text
[Shop Cover Photo]

ABC Grocery

⭐ 4.5
🟢 Open
📍 0.8 km away

[Get Directions]

────────────────────

Shop Information

📍 Full Address
📞 Contact
⏰ Opening Hours

────────────────────

Available Products

[Product]
[Product]
[Product]

────────────────────

Delivery

🛵 Home Delivery Available
₹10 delivery fee

[View All Products]
```

## Important

The shop location must be stored as geographic coordinates:

```text
latitude
longitude
```

Do not depend only on a text address.

---

# 13. Google Maps Direction Flow

Seller sets:

```text
Shop latitude
Shop longitude
```

Buyer taps:

```text
[Get Directions]
```

The app should open a map/navigation destination using those coordinates.

The app should also show the shop address before leaving Local Market.

Recommended UI:

```text
📍 ABC Grocery

12 Market Road
Beldanga

[Open in Google Maps]
```

---

# 14. Seller Registration

Seller onboarding should be short.

## Step 1

```text
Create Seller Account

Mobile Number
[____________]

OTP
[____________]

[Continue]
```

## Step 2

```text
Create Your Shop

Shop Name
[____________]

Shop Category
[ Select ]

Owner Name
[____________]

Phone
[____________]
```

## Step 3 — Location

This step is critical.

```text
Set Shop Location

📍 We need your shop's exact
location so customers can find you.

[Use Current Location]

OR

[Select Location on Map]

Shop Address
[________________]

[Confirm Location]
```

After confirmation:

```text
✓ Shop location saved

ABC Grocery
📍 23.XXXX, 88.XXXX

[Continue]
```

---

# 15. Seller Shop Profile

Seller should be able to edit:

- Shop name
- Shop photo
- Category
- Address
- GPS location
- Phone
- Opening hours
- Delivery availability
- Delivery fee
- Description

---

# 16. Add Product — Most Important Seller Feature

The seller should be able to publish a product in less than one minute.

Main button:

```text
+ Add Product
```

Then:

```text
Add Product

┌──────────────────────────┐
│                          │
│       📸 CAMERA          │
│                          │
│   Take Original Photo    │
│                          │
└──────────────────────────┘

OR

[Choose from Gallery]
```

For the MVP, prioritize camera capture.

Then:

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
[Vegetables ▼]

Description
[Fresh local tomato]

Delivery Available
[ ON ]

[Publish Product]
```

---

# 17. Original Photo System

The seller-upload flow should communicate:

> "Take a photo of the product currently available in your shop."

Potential product metadata:

```text
image_url
uploaded_at
seller_id
shop_id
```

You can later add:

- Image moderation
- Duplicate image detection
- Watermark
- Photo timestamp
- "Photo updated today" indicator

Do not claim an image is definitely original merely because it came from a camera. If verification matters, implement a real verification mechanism.

---

# 18. Seller Dashboard

Recommended dashboard:

```text
Good Morning, Seller 👋

ABC Grocery

Today's Summary

Orders        Sales
   8           ₹2,450

────────────────────

Quick Actions

[+ Add Product]

[My Products]

[Orders]

[Shop Profile]

────────────────────

Recent Orders

#LM1024
₹180
New Order

[View]
```

---

# 19. Seller Order Screen

Each order:

```text
Order #LM1024

Customer:
Gourab

Items:
Tomato 2kg     ₹80
Rice 1kg        ₹60

Delivery        ₹10
────────────────
Total           ₹150

Delivery Type:
🛵 Home Delivery

[Accept Order]
[Reject]
```

For visit-shop orders:

```text
🏪 Customer will visit shop

No delivery required.
```

---

# 20. Buyer Checkout

Checkout should clearly distinguish purchase mode.

```text
Checkout

Purchase Method

◉ Home Delivery
  Delivery fee ₹10

○ Visit Shop
  No delivery fee

────────────────

Items
Tomato × 2      ₹80

Delivery        ₹10
────────────────
Total           ₹90

[Place Order]
```

If Visit Shop is selected:

```text
Items            ₹80
Delivery          ₹0
────────────────
Total             ₹80

🏪 Pick up from:
ABC Grocery

[Get Directions]
[Confirm Shop Purchase]
```

---

# 21. Delivery Address

For delivery:

```text
Delivery Address

Name
Phone

House / Flat
Street / Area
City
PIN

📍 Map Location

[Use Current Location]

[Save Address]
```

For accurate local delivery, store both:

```text
address_text
latitude
longitude
```

---

# 22. Order Status

Use a simple timeline:

```text
✓ Order Placed
      ↓
✓ Seller Accepted
      ↓
✓ Preparing
      ↓
● Out for Delivery
      ↓
○ Delivered
```

For shop pickup:

```text
✓ Order Confirmed
      ↓
● Ready for Pickup
      ↓
○ Collected
```

---

# 23. Cart Rules

A major architecture decision:

### MVP recommendation

Allow **one shop per cart**.

Why?

If a buyer adds products from three different shops, delivery and order handling become much more complicated.

Use:

```text
Cart
  ↓
One Shop
  ↓
One Order
```

Later you can support multi-shop carts.

---

# 24. Database Architecture

A simple backend structure:

```text
users
  id
  name
  phone
  role
  created_at

shops
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

products
  id
  shop_id
  name
  price
  unit
  stock_quantity
  category
  description
  image_url
  image_uploaded_at
  available
  created_at
  updated_at

orders
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

order_items
  id
  order_id
  product_id
  quantity
  price

reviews
  id
  buyer_id
  shop_id
  order_id
  rating
  comment
  created_at
```

---

# 25. Important Order Types

Use a simple enum:

```text
VISIT_SHOP
HOME_DELIVERY
```

This is better than trying to infer the purchase method later.

---

# 26. Recommended Tech Stack

For a first production-quality MVP:

## Frontend

Choose one:

### Option A — Flutter

Good when you want:

- Android
- iOS
- One codebase
- Camera integration
- Location
- Maps
- Fast UI development

### Option B — React Native

Good when you prefer JavaScript/TypeScript.

For a beginner-friendly single-codebase mobile app, Flutter is a strong choice.

## Backend

Recommended:

```text
Firebase
```

Potential services:

- Firebase Authentication
- Firestore
- Firebase Storage
- Firebase Cloud Messaging
- Cloud Functions

Alternative:

```text
Supabase
```

Useful if you prefer PostgreSQL.

---

# 27. Suggested MVP Stack

```text
Flutter
   ↓
Firebase Authentication
   ↓
Cloud Firestore
   ↓
Firebase Storage
   ↓
Cloud Functions
   ↓
Google Maps Platform
```

For payment, add a payment provider only after the core ordering workflow works.

---

# 28. Google Maps Data Model

Store:

```text
shop:
{
  shop_name: "ABC Grocery",
  address: "Market Road, Beldanga",
  latitude: 23.xxxxx,
  longitude: 88.xxxxx
}
```

Never store only:

```text
"Near Beldanga Market"
```

because that is not precise enough for navigation.

---

# 29. Nearby Search

The home screen should prioritize shops based on distance.

Conceptually:

```text
User Location
      ↓
Find Nearby Shops
      ↓
Calculate / Query Distance
      ↓
Sort by Distance
      ↓
Show Closest Shops
```

Example:

```text
ABC Grocery       0.4 km
Maa Store         0.7 km
New Market        1.2 km
Rahman Store      1.8 km
```

For large-scale production, use a proper geospatial query/index rather than downloading every shop and calculating all distances on the phone.

---

# 30. Navigation Structure

Recommended buyer bottom navigation:

```text
🏠 Home
🔎 Search
🛒 Cart
📦 Orders
👤 Profile
```

Recommended seller navigation:

```text
📊 Dashboard
📦 Products
🧾 Orders
🏪 Shop
👤 Profile
```

Do not mix buyer and seller navigation unnecessarily.

---

# 31. Authentication and Roles

Use a single user system with roles:

```text
BUYER
SELLER
ADMIN
```

A seller can potentially also shop as a buyer, but the MVP can keep the interfaces separate for simplicity.

---

# 32. Shop Verification

Admin should be able to verify shops.

Status:

```text
PENDING
VERIFIED
REJECTED
SUSPENDED
```

Buyer UI:

```text
✓ Verified Shop
```

Only display the badge when the backend actually marks the shop verified.

---

# 33. Product Availability

Do not show stale products indefinitely.

Recommended:

```text
Available
Low Stock
Out of Stock
```

Seller can update stock.

Example:

```text
Tomato
₹40/kg

🟢 Available

Stock: 25 kg
```

If stock reaches zero:

```text
🔴 Out of Stock
```

---

# 34. Delivery Architecture

MVP:

```text
Buyer
  ↓
Seller
  ↓
Seller handles delivery
```

Do not build a complex delivery-partner network in version 1 unless the business requires it.

Later:

```text
Seller
   ↓
Delivery Partner
   ↓
Buyer
```

Possible future features:

- Delivery partner app
- Live tracking
- Delivery assignment
- Distance-based pricing
- Delivery earnings

---

# 35. Pricing Rules

For MVP:

```text
Product subtotal
+
₹10 delivery fee
=
Total
```

But keep the database flexible:

```text
delivery_fee
```

instead of hardcoding ₹10 everywhere.

Later you can support:

```text
0 km – 2 km      ₹10
2 km – 5 km      ₹20
5 km+            ₹30
```

---

# 36. Notifications

Important notifications:

### Buyer

- Order placed
- Seller accepted
- Order ready
- Out for delivery
- Delivered

### Seller

- New order
- Order cancelled
- Product low stock

Use push notifications for these.

---

# 37. UI States You Must Design

Do not design only the "happy path."

Every screen should have:

### Loading

```text
Loading nearby shops...
```

### Empty

```text
No shops found nearby.

Try increasing your search area.
```

### Error

```text
Something went wrong.

[Try Again]
```

### Offline

```text
You're offline.

Check your internet connection.
```

### Permission denied

```text
Location permission is disabled.

You can still enter your location manually.
```

---

# 38. Accessibility

Use:

- Large readable text
- Strong contrast
- Buttons large enough to tap
- Icons + text instead of icons alone
- Clear error messages
- Avoid tiny clickable elements

The app should work well on inexpensive Android phones too.

---

# 39. Performance

Because the app is intended for local users, optimize for slower networks.

Use:

- Compressed product images
- Lazy loading
- Pagination
- Cached images
- Minimal animations
- Efficient Firestore queries
- Avoid loading every shop/product at once

Product images should be resized before/while uploading.

---

# 40. Security

Never trust the mobile app with important business rules.

Backend should verify:

- User identity
- Seller ownership of shop
- Product ownership
- Product price
- Stock
- Order totals
- Delivery fee
- Order status transitions

Example:

```text
Client says:
price = ₹10

Database says:
price = ₹40

Backend must use the trusted database value.
```

Never calculate final order totals only on the client.

---

# 41. Admin Panel

Admin dashboard:

```text
LOCAL MARKET ADMIN

Users             1,250
Sellers             84
Shops               72
Products          2,430
Orders            3,120

────────────────────

Pending Shops       5
Reported Products   3
Open Issues         2
```

Admin actions:

- Verify seller
- Verify shop
- Suspend shop
- Remove product
- Review reports
- Manage categories
- View orders
- Manage delivery settings

---

# 42. Recommended Build Order

Do not build everything simultaneously.

## Phase 1 — UI prototype

Build:

1. Splash
2. Location
3. Home
4. Search
5. Product details
6. Shop details
7. Seller registration
8. Add product
9. Cart
10. Checkout
11. Orders

Use fake/mock data initially.

---

# 43. Phase 2 — Authentication

Implement:

```text
Phone
 ↓
OTP
 ↓
User account
 ↓
Buyer/Seller role
```

---

# 44. Phase 3 — Seller System

Implement:

```text
Seller
 ↓
Shop
 ↓
Shop location
 ↓
Product
 ↓
Real image
 ↓
Publish
```

Test this before building advanced buyer features.

---

# 45. Phase 4 — Buyer Discovery

Implement:

```text
User Location
 ↓
Nearby Shops
 ↓
Nearby Products
 ↓
Search
 ↓
Product Details
```

---

# 46. Phase 5 — Ordering

Implement:

```text
Cart
 ↓
Visit Shop OR Home Delivery
 ↓
Address if delivery
 ↓
Order
 ↓
Seller notification
 ↓
Order status
```

---

# 47. Phase 6 — Maps

Implement:

```text
Shop GPS
 ↓
Shop Details
 ↓
Get Directions
 ↓
External map/navigation
```

Test with several real shops before launch.

---

# 48. Phase 7 — Admin

Implement:

```text
Seller verification
Shop verification
Product moderation
Order monitoring
Reports
```

---

# 49. Phase 8 — Production Hardening

Before public launch:

- Security rules
- Error handling
- Analytics
- Crash reporting
- Image compression
- Backup strategy
- Privacy policy
- Terms
- Seller verification
- Abuse reporting
- Order cancellation rules

---

# 50. Best First-Version Feature Set

The MVP should contain only:

```text
✓ Buyer login
✓ Seller login
✓ Shop creation
✓ Exact shop location
✓ Product photo upload
✓ Product listing
✓ Nearby shop discovery
✓ Product search
✓ Shop page
✓ Google Maps directions
✓ Cart
✓ Visit Shop option
✓ Home Delivery option
✓ ₹10 configurable delivery fee
✓ Order creation
✓ Seller order management
✓ Order status
✓ Push notifications
✓ Basic admin panel
```

Do not initially add:

```text
✗ Complex loyalty system
✗ Social feed
✗ Live chat
✗ AI recommendations
✗ Multi-shop cart
✗ Advanced delivery fleet
✗ Complicated coupons
✗ Live GPS delivery tracking
```

Build those after the core marketplace works.

---

# 51. Folder Structure — Flutter Example

```text
lib/
│
├── core/
│   ├── theme/
│   ├── constants/
│   ├── utils/
│   └── services/
│
├── models/
│   ├── user.dart
│   ├── shop.dart
│   ├── product.dart
│   └── order.dart
│
├── features/
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
├── widgets/
│   ├── product_card.dart
│   ├── shop_card.dart
│   ├── location_button.dart
│   └── primary_button.dart
│
└── main.dart
```

Keep features separated so the project does not become one giant file.

---

# 52. Component Design System

Create reusable components:

```text
PrimaryButton
SecondaryButton
ProductCard
ShopCard
PriceText
RatingBadge
AvailabilityBadge
LocationRow
OrderStatusTimeline
SearchBar
CategoryCard
ImagePickerCard
```

This makes the UI consistent.

---

# 53. Product Photo UX

The ideal interaction:

```text
Seller taps "+"
      ↓
Add Product
      ↓
Camera opens
      ↓
Take photo
      ↓
Preview
      ↓
Retake / Use Photo
      ↓
Product details
      ↓
Publish
```

Avoid forcing the seller through unnecessary screens.

---

# 54. Shop Location UX

The ideal interaction:

```text
Create Shop
    ↓
Set Location
    ↓
Use Current Location
    ↓
Map opens
    ↓
Pin appears
    ↓
Seller adjusts pin if necessary
    ↓
Confirm
    ↓
Address generated
    ↓
Save
```

Always provide manual adjustment because GPS can be slightly inaccurate.

---

# 55. Trust and Anti-Fraud

Potential future systems:

- Seller KYC/verification
- Shop verification
- Phone verification
- Product report
- Fake listing report
- Review system
- Suspicious activity detection

Never display "Verified" unless the verification actually happened.

---

# 56. Product Listing Ranking

Initial ranking:

```text
1. Available
2. Nearby
3. Open shop
4. Relevant search match
5. Recently updated
```

Do not make paid sellers automatically dominate the MVP unless you have a clearly disclosed sponsored system.

---

# 57. Business Model — Later

Possible revenue:

### Delivery fee

Example:

```text
Buyer pays ₹10
Seller receives product amount
Local Market keeps a configured delivery/service component
```

The exact financial model should be decided separately.

### Seller subscription

Future:

```text
Free
Pro Seller
Business Seller
```

### Featured shop

Clearly label promoted listings.

---

# 58. Launch Strategy

Do not launch everywhere immediately.

Start with:

```text
1 local market
       ↓
10–20 shops
       ↓
100–300 products
       ↓
Real buyers
       ↓
Fix problems
       ↓
Expand to nearby markets
```

The biggest advantage of Local Market is **local density**, not having millions of listings.

A small area with many active shops is better than a huge area with empty listings.

---

# 59. Testing Checklist

Before launch, test:

- Seller registration
- Shop location
- Product camera
- Gallery upload
- Product price
- Stock
- Product visibility
- Search
- Nearby sorting
- Shop page
- Google Maps button
- Visit Shop order
- Delivery order
- ₹10 delivery fee
- Address
- Seller accepts order
- Seller rejects order
- Order cancellation
- Notifications
- Out-of-stock product
- Shop closed status
- Poor internet
- Location permission denied
- Duplicate orders
- Invalid price
- Unauthorized seller actions

---

# 60. Definition of Done for MVP

The MVP is ready when a real seller can:

```text
Create account
      ↓
Create shop
      ↓
Set exact shop location
      ↓
Take product photo
      ↓
Add price/stock
      ↓
Publish
```

and a real buyer can:

```text
Open Local Market
      ↓
Find nearby product
      ↓
See real product photo
      ↓
See shop
      ↓
Choose:
   ├── Visit Shop → Google Maps
   └── Home Delivery → ₹10 fee
      ↓
Place order
      ↓
Track order
```

If these two complete journeys work reliably, you have a real MVP.

---

# 61. Final Product Principle

Local Market should not try to become another giant online marketplace.

Its strongest identity is:

> **"Your nearby shops, their real products, and the choice to visit or get them delivered."**

Every feature should support this principle.

---

# Getting Started — First Build Session

## Step 1

Create the project:

```text
local_market/
```

Choose Flutter if you want one mobile codebase.

## Step 2

Create the first screens:

```text
Splash
Location Permission
Home
Search
Shop Details
Product Details
Seller Registration
Shop Setup
Add Product
Cart
Checkout
Orders
```

## Step 3

Use mock data first.

Create 3 fake shops:

```text
ABC Grocery
Maa Store
New Market Store
```

Create around 10 products.

Do not connect the database yet.

## Step 4

Build the complete buyer journey:

```text
Home
 → Product
 → Shop
 → Visit Shop / Delivery
 → Checkout
 → Order
```

## Step 5

Build the seller journey:

```text
Seller
 → Shop Setup
 → Location
 → Add Product
 → Publish
```

## Step 6

Connect authentication.

## Step 7

Connect database and image storage.

## Step 8

Connect maps.

## Step 9

Connect real orders.

## Step 10

Test with a small group of real local shops.

---

# First Milestone

Do not try to build the entire platform in one step.

The first milestone should be:

> **One seller can create a shop, set its exact location, photograph a product, publish it, and one buyer can discover that product, see the shop location, choose Visit Shop or Home Delivery, and place an order.**

Once that works end-to-end, expand the platform.
