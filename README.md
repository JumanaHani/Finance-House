# finance_house - UAE Top-UP APP

This Flutter application allows users to **add credit to UAE phone numbers**, manage their top-up beneficiaries, explore top-up options, and execute top-up transactions. The app follows **Clean Architecture** principles and uses **Cubit** for state management.



## Features

- Add, view, and manage up to **5 beneficiaries**.
- Top-up multiple beneficiaries with **monthly limits**:
  - **Non-verified users:** max AED 500 per beneficiary per month.
  - **Verified users:** max AED 1,000 per beneficiary per month.(User verification (isVerified) is included in the User entity)
  - **Total top-up per month:** max AED 3,000 for all beneficiaries.
- Apply **AED 3 transaction fee** per top-up.
- View available top-up options: AED 5, 10, 20, 30, 50, 75, 100.
- Responsive and intuitive UI.
- Clean Architecture:
  - `presentation` → UI + Cubit  
  - `domain` → Entities, UseCases, Repository interface  
  - `data` → Models, Repository implementation, RemoteDataSource
- Mock backend with simulated network delays for development/testing.
- Error handling for API failures and business rules enforced in the domain layer.
- Unit tests included for Cubit.(to run the test flutter test test/features/topup/presentation/cubit/topup_cubit_test.dart
)

---

## Setup Instructions

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/finance_house.git
cd finance_house
