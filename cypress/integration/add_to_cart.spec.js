describe('Jungle App - Add to Cart', () => {
  it('should visit the home page', () => {
    cy.visit('/');
  });

  it('should see the cart increases by one when clicking Add button', () => {
    cy.get('.btn').contains('Add').click({ force: true });
    cy.get('.nav-link').should('contain.text', '1');
  });
});