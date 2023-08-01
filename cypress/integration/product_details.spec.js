describe('Jungle App - Product Details Page', () => {
  it('should visit the home page', () => {
    cy.visit('/');
  });

  it('should see the product details page when clicking on the product', () => {
    const productName = 'Giant Tea';
    cy.contains('.products article', productName).click();
    cy.get('.products-show').should('be.visible');
  });
});