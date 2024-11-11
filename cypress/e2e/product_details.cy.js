describe('template spec', () =>{
  it('successfully visits site', () => {
    cy.visit('/');
  });

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("click on the first product", () => {
    cy.visit("/");
    cy.get('.products > :nth-child(1)').click();
  });
});