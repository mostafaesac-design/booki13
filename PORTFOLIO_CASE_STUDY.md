# Bookia Portfolio Case Study

## Project summary

Bookia is a bilingual Flutter commerce app built to turn a static bookstore UI
into a maintainable, API-driven mobile product.

## The challenge

The original project mixed local cart/order data with a small number of live
endpoints. Several account and support screens were present visually but were
not connected to the backend. Checkout also opened an order-details mockup
instead of creating a real order.

## The solution

- Centralized the API contract and reused a single authenticated Dio client.
- Converted cart and wishlist flows to server-synchronized Cubits.
- Connected profile, password, deletion, support, checkout, and order APIs.
- Separated checkout from read-only order details.
- Added loading, empty, error, retry, and duplicate-action protection.
- Added defensive JSON parsing for inconsistent product shapes.

## Result

The application now demonstrates the core workflow clients expect from a
commerce portfolio project: authenticate, browse, save, add to cart, place an
order, and inspect order history. The repository includes clear setup guidance
and model-parsing tests.

## Suggested Upwork description

> I built and integrated a bilingual Flutter bookstore using Cubit, Dio, and a
> feature-first architecture. The app includes token authentication,
> server-synced cart and wishlist, profile management, checkout, order history,
> localization, defensive API parsing, and resilient loading/error states.

## Demo video outline (60–75 seconds)

1. Login and session persistence.
2. Home, product details, search, and localization.
3. Add/remove wishlist items.
4. Add a product, change quantity, and show persisted cart state.
5. Checkout and display the returned order number.
6. Open My Orders and a server-backed order detail.
7. Edit profile and show support screens.
