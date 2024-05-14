# Pipeline CRM Homework Assignment

## Notes for the possible improvements
There is a list with proposals about different fixes and improvements which have not been implemented but which I found necessary to mention:
- Add not null/unique constraints on the database level for example for company names or (company name + industry) fields.
- Also, indexes for names, industries could speed up LIKE search. This is why the "LIKE%" is used instead of "%LIKE%"
- Add the corresponding validation for the models - presence, uniqueness, numericality for amounts etc
- Deals statuses could be implemented as ENUM to have additional constraint on DB level.
- Backend filtration logic could be changed to more scalable way with smth like searchable concern or some query builder where we could pass field name and field value to get the query condition.
- Interface is not very useful for now. Possible improvements here:
  1. add clear filters button
  2. fix page switch (table width is changed)
  3. add sorting
  4. add opportunity to set per page value
  5. add opportunity to choose certain page etc.
- Loading component could be useful for UX when we have big number of data.
- There is still no errors handling except catch operator on frontend side. Some concern with `rescue_from` could be added on backend side to handle different types of errors and return the corresponding HTTP codes. And user friendly messages should be displayed on the frontend side.
- Validation for the request parameters could be added on the backend and if there is some invalid param system should return 400 response.
- Add more specs: there could be specs for pagination, sorting, multiple filters for the service. And also some integration specs which test the API requests and responses.
- API docs like swagger could be added to describe endpoints. Also rswag gem provides the integration testing logic.
- Add smth like authorization for the read requests. As we don't have any users and current endpoint could be public, maybe it could be some HTTP basic auth credentials or some throttling to prevent the DDoS attacks etc.
- Add some containerization solution to be able to get started faster and to be more scalably in production
- Add and set up rubocop gem and eslint to support common codestyle rules.
- Research how the socket database connection approach could be applied with ENV variables for the local development process. For now I just commented out this line and swith to the password based connection but it's definitely not a good solution :)