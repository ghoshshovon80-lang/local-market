# Local Market — Implementation Plan

## Purpose

This file is the step-by-step roadmap for building, testing, documenting, and pushing the **Local Market** app to GitHub.

The project goal is a ₹0-cost MVP where possible, using free/open-source tools and free tiers. Do not add online payments in the MVP.

---

# 1. Core Product

Local Market connects buyers with nearby physical shops.

Core flow:

```text
Seller → Create Shop → Set GPS Location → Take Product Photo
       → Add Price/Stock → Publish

Buyer → Find Nearby Product → Open Shop
      → Visit Shop + Get Directions
      OR
      → Home Delivery + ₹10 default delivery fee → Order
```

The app should remain focused on **real local shops, real product photos, nearby discovery, physical shop visits, and optional delivery**.

---

# 2. Files the AI IDE Must Read

Before coding, provide the AI IDE:

1. `Local_Market_Builder_Playbook.md`
2. `Getting_Started_Local_Market.md`
3. `Local_Market_Implementation_Plan.md`

The AI IDE must read all three before implementation.

Do not ask it to build the entire app in one command.

---

# 3. Development Rule

Every phase follows:

```text
Read specification
↓
Inspect existing code
↓
Implement ONE phase
↓
Run analyzer/tests
↓
Fix errors
↓
Manual test
↓
Git commit
↓
Git push
↓
Start next phase
```

Never skip the testing and Git checkpoint.

---

# 4. Recommended Stack

```text
Frontend: Flutter + Dart
Backend: Firebase free tier initially
Database: Firestore
Image storage: Firebase Storage
Authentication: Firebase Auth
Notifications: Firebase Cloud Messaging
Maps: Google Maps/navigation integration
Repository: GitHub
```

Keep external services replaceable.

Do not enable paid services unless necessary. Free-tier limits can change, so check provider pricing before enabling anything that could create charges.

---

# 5. GitHub Repository

Repository name:

```text
local-market
```

Recommended structure:

```text
local-market/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CHANGELOG.md
├── .gitignore
├── docs/
│   ├── Local_Market_Builder_Playbook.md
│   ├── Getting_Started_Local_Market.md
│   └── Local_Market_Implementation_Plan.md
├── lib/
├── test/
├── assets/
└── screenshots/
```

Never commit:

```text
API keys
Passwords
Private credentials
.env files containing secrets
Service-account private keys
Personal data
```

---

# 6. Git Commit Format

Use clear commits:

```text
feat: add buyer home
feat: add seller shop setup
feat: add product creation
feat: add authentication
feat: add shop location

fix: correct checkout calculation
ui: improve product card
test: add product tests
docs: update README
chore: update dependencies
```

Avoid vague messages such as:

```text
update
final
new
test
changes
```

---

# 7. PHASE 0 — Workspace Setup

## Goal

Prepare the development environment and GitHub repository.

## Tasks

- [ ] Install Flutter
- [ ] Install Git
- [ ] Install Android tooling
- [ ] Install AI IDE
- [ ] Create GitHub repository
- [ ] Create Flutter project
- [ ] Run default app
- [ ] Confirm Android build works

Commands:

```bash
flutter doctor
flutter create local_market
cd local_market
flutter run
```

## Git checkpoint

```bash
git init
git add .
git commit -m "chore: initialize Local Market Flutter project"
git branch -M main
git remote add origin <YOUR_GITHUB_REPOSITORY>
git push -u origin main
```

### GitHub result

The repository now contains the initial working Flutter project.

---

# 8. PHASE 1 — Project Architecture

## Goal

Create a clean project foundation.

## Tasks

- [ ] `core/`
- [ ] `models/`
- [ ] `features/`
- [ ] `widgets/`
- [ ] Theme
- [ ] Routes
- [ ] Constants
- [ ] Service layer

Expected:

```text
lib/
├── core/
├── models/
├── features/
└── widgets/
```

## Test

```bash
flutter analyze
flutter test
flutter run
```

## Git

```bash
git add .
git commit -m "chore: establish Local Market architecture"
git push
```

---

# 9. PHASE 2 — Design System

## Goal

Create the visual identity.

Use:

```text
Primary: Green
Secondary: Warm Orange/Yellow
Background: Light Neutral
Text: Dark Charcoal
```

Create reusable:

- [ ] Buttons
- [ ] Cards
- [ ] Inputs
- [ ] App bars
- [ ] Navigation
- [ ] Badges
- [ ] Spacing
- [ ] Typography

Design personality:

```text
Local
Friendly
Modern
Trustworthy
Simple
```

## Git

```bash
git add .
git commit -m "ui: create Local Market design system"
git push
```

---

# 10. PHASE 3 — Splash + Location

## Goal

Build first-launch experience.

Screens:

```text
Splash
↓
Location Explanation
↓
Allow Location
OR
Manual Location
```

Tasks:

- [ ] Logo
- [ ] Tagline
- [ ] Permission UI
- [ ] Manual fallback
- [ ] Loading state
- [ ] Error state

Never make the app unusable when location permission is denied.

## Test

- [ ] Permission allowed
- [ ] Permission denied
- [ ] Location unavailable
- [ ] App restart

## Git

```bash
git add .
git commit -m "feat: add splash and location onboarding"
git push
```

---

# 11. PHASE 4 — Buyer Home

## Goal

Build the main customer discovery screen using mock data.

Include:

```text
Location
Search
Categories
Nearby Shops
Nearby Products
Bottom Navigation
```

Buyer navigation:

```text
Home
Search
Cart
Orders
Profile
```

## Git

```bash
git add .
git commit -m "feat: build buyer home experience"
git push
```

---

# 12. PHASE 5 — Search + Categories

## Goal

Find products, shops, and categories.

Support:

```text
Product search
Shop search
Category search
```

Filters:

```text
Nearest
Lowest Price
Available Now
Delivery Available
```

## Git

```bash
git add .
git commit -m "feat: add product and shop search"
git push
```

---

# 13. PHASE 6 — Product Details

## Goal

Show product information and the two purchase paths.

Show:

```text
Large photo
Product name
Price/unit
Availability
Shop name
Distance
Shop information
```

Actions:

```text
🏪 Visit Shop
🛵 Home Delivery
Add to Cart
```

## Git

```bash
git add .
git commit -m "feat: add product details and purchase options"
git push
```

---

# 14. PHASE 7 — Shop Details

## Goal

Create the physical shop profile.

Show:

```text
Shop photo
Shop name
Verified status
Open/Closed
Distance
Address
Phone
Opening hours
Delivery
Products
Get Directions
```

Every shop must have:

```text
latitude
longitude
address
```

Do not rely only on a text address.

## Git

```bash
git add .
git commit -m "feat: add local shop profile"
git push
```

---

# 15. PHASE 8 — Maps

## Goal

Allow the buyer to navigate to the shop.

Flow:

```text
Shop Details
↓
Get Directions
↓
Map/navigation
```

Use shop coordinates:

```text
latitude
longitude
```

If map credentials are not ready, create the integration interface and mock flow first.

## Test

- [ ] Valid coordinates
- [ ] Invalid coordinates
- [ ] Missing coordinates
- [ ] Navigation action

## Git

```bash
git add .
git commit -m "feat: add shop directions integration"
git push
```

---

# 16. PHASE 9 — Seller Onboarding

## Goal

Build seller account flow.

Screens:

```text
Seller Login
Seller Registration
OTP
Seller Dashboard
```

Tasks:

- [ ] Phone input
- [ ] OTP UI
- [ ] Validation
- [ ] Loading
- [ ] Errors

Initially mock authentication is acceptable.

## Git

```bash
git add .
git commit -m "feat: add seller onboarding"
git push
```

---

# 17. PHASE 10 — Seller Shop Setup

## Goal

Allow seller to create a real shop.

Fields:

```text
Shop Name
Category
Owner Name
Phone
Address
Opening Time
Closing Time
Delivery Enabled
Delivery Fee
```

Location:

```text
Use Current Location
OR
Select Location on Map
```

Store:

```text
latitude
longitude
address
```

## Git

```bash
git add .
git commit -m "feat: add seller shop setup"
git push
```

---

# 18. PHASE 11 — Seller Dashboard

## Goal

Create seller control center.

Show:

```text
Today's Orders
Today's Sales

+ Add Product

Products
Orders
Shop Profile
```

## Git

```bash
git add .
git commit -m "feat: add seller dashboard"
git push
```

---

# 19. PHASE 12 — Add Product

## Goal

Make product publishing extremely fast.

Flow:

```text
+ Add Product
↓
Take Product Photo
↓
Preview
↓
Name
↓
Price
↓
Unit
↓
Stock
↓
Category
↓
Description
↓
Delivery Availability
↓
Publish
```

Prefer camera capture.

Compress large images before upload.

## Git

```bash
git add .
git commit -m "feat: add seller product creation"
git push
```

---

# 20. PHASE 13 — Product Management

Seller can:

- [ ] View products
- [ ] Edit
- [ ] Change price
- [ ] Change stock
- [ ] Mark out of stock
- [ ] Update photo
- [ ] Delete

Statuses:

```text
AVAILABLE
LOW_STOCK
OUT_OF_STOCK
```

## Git

```bash
git add .
git commit -m "feat: add seller product management"
git push
```

---

# 21. PHASE 14 — Firebase Backend

## Goal

Connect real backend.

Use:

```text
Firebase Authentication
Firestore
Firebase Storage
```

Later if needed:

```text
Cloud Messaging
Cloud Functions
```

Collections:

```text
users
shops
products
orders
order_items
reviews
```

Never commit private credentials.

## Git

```bash
git add .
git commit -m "feat: connect Firebase backend"
git push
```

---

# 22. PHASE 15 — Real Authentication

Roles:

```text
BUYER
SELLER
ADMIN
```

Flow:

```text
Phone
↓
OTP
↓
Account
↓
Role
```

Test:

- [ ] New user
- [ ] Existing user
- [ ] Wrong OTP
- [ ] Logout
- [ ] Re-login
- [ ] Unauthorized access

## Git

```bash
git add .
git commit -m "feat: implement real authentication"
git push
```

---

# 23. PHASE 16 — Real Shops

Flow:

```text
Seller creates shop
↓
Firestore
↓
Buyer Home
↓
Nearby Shops
```

Tasks:

- [ ] Save shop
- [ ] Read shops
- [ ] Display shops
- [ ] Distance
- [ ] Shop details

## Git

```bash
git add .
git commit -m "feat: connect real shop listings"
git push
```

---

# 24. PHASE 17 — Real Products

Flow:

```text
Seller
↓
Product photo
↓
Storage
↓
Product record
↓
Buyer
```

Tasks:

- [ ] Upload image
- [ ] Store URL
- [ ] Create
- [ ] Read
- [ ] Update
- [ ] Stock

## Git

```bash
git add .
git commit -m "feat: connect real product catalog"
git push
```

---

# 25. PHASE 18 — Cart

## MVP Rule

**One shop per cart.**

If another shop's product is selected, show a clear confirmation before replacing the cart.

Cart stores:

```text
Product
Quantity
Price
Subtotal
Shop
```

Validate current price and stock before checkout.

## Git

```bash
git add .
git commit -m "feat: add one-shop cart"
git push
```

---

# 26. PHASE 19 — Checkout

Two modes:

## Visit Shop

```text
Subtotal
+
₹0 delivery
=
Total
```

## Home Delivery

```text
Subtotal
+
Delivery Fee
=
Total
```

Default delivery fee:

```text
₹10
```

Store it as configurable data. Do not hardcode ₹10 everywhere.

## MVP payment

Do not add online payment.

Use:

```text
Pay at Shop
OR
Cash on Delivery
```

## Git

```bash
git add .
git commit -m "feat: implement visit shop and home delivery checkout"
git push
```

---

# 27. PHASE 20 — Delivery Address

Store:

```text
name
phone
address
latitude
longitude
```

Provide:

```text
Use Current Location
OR
Enter Manually
```

## Git

```bash
git add .
git commit -m "feat: add delivery address"
git push
```

---

# 28. PHASE 21 — Orders

Order fields:

```text
order_id
buyer_id
shop_id
order_type
items
subtotal
delivery_fee
total
status
delivery_address
delivery_latitude
delivery_longitude
created_at
```

Order types:

```text
VISIT_SHOP
HOME_DELIVERY
```

## Git

```bash
git add .
git commit -m "feat: implement order creation"
git push
```

---

# 29. PHASE 22 — Seller Order Management

Delivery:

```text
PENDING
↓
ACCEPTED
↓
PREPARING
↓
READY
↓
OUT_FOR_DELIVERY
↓
DELIVERED
```

Shop visit:

```text
PENDING
↓
ACCEPTED
↓
READY
↓
COLLECTED
```

Seller actions must be validated by the backend.

## Git

```bash
git add .
git commit -m "feat: add seller order management"
git push
```

---

# 30. PHASE 23 — Buyer Order Tracking

Build:

```text
Order Placed
↓
Seller Accepted
↓
Preparing
↓
Ready / Out for Delivery
↓
Delivered
```

## Git

```bash
git add .
git commit -m "feat: add buyer order tracking"
git push
```

---

# 31. PHASE 24 — Notifications

Seller:

```text
New Order
Order Cancelled
Low Stock
```

Buyer:

```text
Order Accepted
Order Ready
Out for Delivery
Delivered
```

Use push notifications where the free tier supports the required usage.

## Git

```bash
git add .
git commit -m "feat: add order notifications"
git push
```

---

# 32. PHASE 25 — Admin

Admin features:

```text
Users
Sellers
Shops
Products
Orders
Reports
Categories
```

Shop statuses:

```text
PENDING
VERIFIED
REJECTED
SUSPENDED
```

Only verified shops get:

```text
✓ Verified Shop
```

## Git

```bash
git add .
git commit -m "feat: add admin management"
git push
```

---

# 33. PHASE 26 — Security

Verify:

- [ ] Authentication required
- [ ] Seller can modify only own shop
- [ ] Seller can modify only own products
- [ ] Buyer can access only own private orders
- [ ] Users cannot change their own role
- [ ] Price validated server-side
- [ ] Stock validated server-side
- [ ] Order totals calculated from trusted data
- [ ] Delivery fee validated

Never trust the mobile client for final business values.

## Git

```bash
git add .
git commit -m "security: enforce backend authorization rules"
git push
```

---

# 34. PHASE 27 — Error States

Every important screen needs:

```text
Loading
Empty
Error
Offline
Permission denied
```

Examples:

```text
Loading nearby shops...

No shops found nearby.

Something went wrong.
[Try Again]

You're offline.

Location permission is disabled.
[Choose Manually]
```

## Git

```bash
git add .
git commit -m "fix: improve loading error and empty states"
git push
```

---

# 35. PHASE 28 — UI Polish

Check:

- [ ] Consistent spacing
- [ ] Typography
- [ ] Button hierarchy
- [ ] Product image ratios
- [ ] Cards
- [ ] Icons
- [ ] Accessibility
- [ ] Small-screen layouts
- [ ] Useful animations only

## Git

```bash
git add .
git commit -m "ui: polish Local Market interface"
git push
```

---

# 36. PHASE 29 — Performance

Optimize:

- [ ] Image compression
- [ ] Lazy loading
- [ ] Pagination
- [ ] Image caching
- [ ] Efficient database queries
- [ ] Avoid loading every shop at once
- [ ] Avoid loading every product at once

## Git

```bash
git add .
git commit -m "perf: optimize app performance"
git push
```

---

# 37. PHASE 30 — Testing

Run:

```bash
flutter format .
flutter analyze
flutter test
flutter build apk
```

Test:

### Unit

- [ ] Price calculation
- [ ] Delivery fee
- [ ] Cart quantity
- [ ] Order total
- [ ] Validation
- [ ] Status transitions

### Widget

- [ ] Product card
- [ ] Shop card
- [ ] Checkout
- [ ] Forms

### Integration

```text
Seller → Shop → Product
Buyer → Product → Cart → Order
Seller → Order → Status
```

## Git

```bash
git add .
git commit -m "test: add MVP test coverage"
git push
```

---

# 38. PHASE 31 — Real Device Testing

Test on a real Android phone.

Check:

- [ ] Camera
- [ ] Image upload
- [ ] Location
- [ ] Maps
- [ ] Login
- [ ] Search
- [ ] Product
- [ ] Cart
- [ ] Checkout
- [ ] Orders
- [ ] Notifications
- [ ] Slow internet
- [ ] Permission denial
- [ ] App restart

---

# 39. PHASE 32 — Documentation

Update:

```text
README.md
CHANGELOG.md
CONTRIBUTING.md
docs/
```

README should explain:

```text
Project
Features
Screenshots
Tech stack
Architecture
Setup
Environment variables
Testing
Roadmap
License
```

Add screenshots of:

```text
Home
Search
Shop
Product
Seller Dashboard
Add Product
Checkout
Orders
```

## Git

```bash
git add .
git commit -m "docs: document Local Market project"
git push
```

---

# 40. PHASE 33 — Final GitHub Cleanup

Before portfolio publication:

- [ ] Remove unused code
- [ ] Remove debug logs
- [ ] Check secrets
- [ ] Check `.gitignore`
- [ ] Format code
- [ ] Analyze
- [ ] Test
- [ ] Build APK
- [ ] Update README
- [ ] Add screenshots
- [ ] Add roadmap
- [ ] Add license

Commands:

```bash
flutter format .
flutter analyze
flutter test
flutter build apk
```

Then:

```bash
git add .
git commit -m "release: prepare Local Market MVP"
git push
```

---

# 41. GitHub Milestones

Create:

```text
Milestone 1 — Foundation
Milestone 2 — Buyer UI
Milestone 3 — Seller UI
Milestone 4 — Backend
Milestone 5 — Orders
Milestone 6 — Maps
Milestone 7 — Admin
Milestone 8 — Testing
Milestone 9 — MVP Release
```

---

# 42. GitHub Issues

Recommended issues:

```text
#1 Initialize Flutter project
#2 Create design system
#3 Build buyer home
#4 Build search
#5 Build shop details
#6 Build product details
#7 Build seller onboarding
#8 Build shop location
#9 Build add product
#10 Connect Firebase
#11 Implement authentication
#12 Implement products
#13 Implement cart
#14 Implement checkout
#15 Implement orders
#16 Implement seller order management
#17 Implement maps
#18 Implement notifications
#19 Build admin
#20 Add security rules
#21 Add tests
#22 Polish UI
#23 Write documentation
#24 Release MVP
```

---

# 43. When to Push

Use:

```text
Build
↓
Run
↓
Test
↓
Fix
↓
Commit
↓
Push
```

Push after every meaningful completed phase.

Do not wait until the whole app is finished.

---

# 44. AI IDE Command Template

At the beginning of every phase, give the AI IDE:

```text
Read these files completely:

- Local_Market_Builder_Playbook.md
- Getting_Started_Local_Market.md
- Local_Market_Implementation_Plan.md

We are currently implementing:

PHASE [NUMBER] — [PHASE NAME]

Tasks:
[copy the phase tasks from the implementation plan]

Rules:

1. Inspect the existing project before editing.
2. Do not break previous functionality.
3. Reuse existing components.
4. Implement only this phase.
5. Do not start the next phase.
6. Run flutter analyze.
7. Run relevant tests.
8. Fix errors before finishing.
9. Summarize files created and modified.
10. Give me a manual testing checklist.
11. Do not add paid services unless explicitly requested.
12. Do not expose or commit secrets.
```

---

# 45. AI IDE Completion Report

After each phase, ask for:

```text
PHASE COMPLETION REPORT

Phase:
Status:

Implemented:
- ...

Files created:
- ...

Files modified:
- ...

Tests:
- ...

Known issues:
- ...

Manual testing:
1. ...
2. ...
3. ...

Recommended Git commit:
...

Next phase:
...
```

---

# 46. Portfolio-Quality Git History

A good history should look like:

```text
release: prepare Local Market MVP
docs: document Local Market project
test: add MVP test coverage
perf: optimize app performance
ui: polish Local Market interface
security: enforce backend authorization rules
feat: add admin management
feat: add order notifications
feat: add buyer order tracking
feat: add seller order management
feat: implement order creation
feat: add delivery address
feat: implement visit shop and home delivery checkout
feat: add one-shop cart
feat: connect real product catalog
feat: connect real shop listings
feat: implement real authentication
feat: connect Firebase backend
feat: add seller product management
feat: add seller product creation
feat: add seller dashboard
feat: add seller shop setup
feat: add seller onboarding
feat: add shop directions integration
feat: add local shop profile
feat: add product details and purchase options
feat: add product and shop search
feat: build buyer home experience
feat: add splash and location onboarding
ui: create Local Market design system
chore: establish Local Market architecture
chore: initialize Local Market Flutter project
```

This makes the development process understandable to another developer.

---

# 47. Cost-Control Rules

For the ₹0 development goal:

- [ ] Use free/open-source tools
- [ ] Use free tiers where available
- [ ] Avoid paid AI APIs
- [ ] Do not buy a domain for MVP
- [ ] Do not buy hosting unless required
- [ ] Do not add online payment
- [ ] Compress images
- [ ] Monitor free-tier usage
- [ ] Never enable paid billing without understanding the provider's limits

Free tiers can change, so verify current pricing before production use.

---

# 48. MVP Payment Strategy

No online payment in the first version.

Use:

```text
Visit Shop → Pay at Shop

Home Delivery → Cash on Delivery
```

Online payment can be a future phase.

---

# 49. Final MVP Test

A real seller must be able to:

```text
Create account
↓
Create shop
↓
Set exact GPS location
↓
Take product photo
↓
Add price
↓
Add stock
↓
Publish
```

A real buyer must be able to:

```text
Open app
↓
Select location
↓
Find product
↓
See shop
↓
See real product photo
↓
See shop location
↓
Choose Visit Shop OR Home Delivery
↓
Place order
```

Seller must then be able to:

```text
Receive
↓
Accept
↓
Prepare
↓
Complete
```

---

# 50. Final Product Principle

Do not optimize for the number of features.

Optimize for one complete reliable experience:

> **A real local seller can publish a real product, and a real customer can discover that product and either find the physical shop or order it for home delivery.**

Once that experience works reliably, expand Local Market.
