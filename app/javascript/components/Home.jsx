import React, { useEffect, useState } from "react";

export default () => {
  // List of fetched companies
  const [companies, setCompanies] = useState([]);

  // Table filters
  const [companyName, setCompanyName] = useState("");
  const [industry, setIndustry] = useState("");
  const [minEmployee, setMinEmployee] = useState("");
  const [minimumDealAmount, setMinimumDealAmount] = useState("");

  // Pagination
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(5);
  const [totalPages, setTotalPages] = useState(0);

  const fetchCompanies = () => {
    const url = `/api/v1/companies?company=${encodeURIComponent(companyName)}&industry=${encodeURIComponent(industry)}&employee=${minEmployee}&amount=${minimumDealAmount}&page=${currentPage}&per_page=${itemsPerPage}`;
    fetch(url)
    .then((res) => res.json())
    .then((res) => {
      setCompanies(res.data);
      setTotalPages(res.total_pages);
    })
    .catch(error => console.error(error));
  };

  // Fetch companies from API initially and on page change
  useEffect(() => {
    fetchCompanies();
  }, [currentPage, itemsPerPage]);

  const handleApplyFilters = () => {
    setCurrentPage(1); // Reset to first page when filters are applied
    fetchCompanies();
  };

  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };


  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h1 className="display-4">Companies</h1>

          <label htmlFor="company-name">Company Name</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="company-name" value={companyName} onChange={e => setCompanyName(e.target.value)} />
          </div>

          <label htmlFor="industry">Industry</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="industry" value={industry} onChange={e => setIndustry(e.target.value)} />
          </div>

          <label htmlFor="min-employee">Minimum Employee Count</label>
          <div className="input-group mb-3">
            <input type="number" min="0" className="form-control" id="min-employee" value={minEmployee} onChange={e => setMinEmployee(e.target.value)} />
          </div>

          <label htmlFor="min-amount">Minimum Deal Amount</label>
          <div className="input-group mb-3">
            <input type="number" min="0" className="form-control" id="min-amount" value={minimumDealAmount} onChange={e => setMinimumDealAmount(e.target.value)} />
          </div>

          <button onClick = {handleApplyFilters}>Get companies</button>

          <table className="table">
            <thead>
              <tr>
                <th scope="col">Name</th>
                <th scope="col">Industry</th>
                <th scope="col">Employee Count</th>
                <th scope="col">Total Deal Amount</th>
              </tr>
            </thead>
            <tbody>
              {companies.map((company) => (
                <tr key={company.id}>
                  <td>{company.name}</td>
                  <td>{company.industry}</td>
                  <td>{company.employee_count}</td>
                  <td>{company.total_amount || 0}</td>
                </tr>
              ))}
            </tbody>
          </table>

          {/* Pagination */}
          <div>
            <button onClick={() => handlePageChange(currentPage - 1)} disabled={currentPage === 1 || totalPages === 0}>Previous</button>
            <span>Page {currentPage} of {totalPages}</span>
            <button onClick={() => handlePageChange(currentPage + 1)} disabled={currentPage === totalPages || totalPages === 0}>Next</button>
          </div>
        </div>
      </div>
    </div>
  )
};
