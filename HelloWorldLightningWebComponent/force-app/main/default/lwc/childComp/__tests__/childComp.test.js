import { createElement } from 'lwc';
import ChildComp from 'c/childComp';
import getRecords from '@salesforce/apex/GetKeyContactRecords.getRecords'
const Apex_KeyContact_List = require('./data/KeyContactList.json');

//jest.mock(modulename, factory func, options); factoryfunction we should make , option used to make the mock virtual (cannot be seen anywhere else)
jest.mock('@salesforce/apex/GetKeyContactRecords.getRecords', ()=>({
    default : jest.fn()
}), {virtual:true})

describe('c-child-comp', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('checking if i get keycontact data', () => {
        // Arrange
        const element = createElement('c-child-comp', {
            is: ChildComp
        });

        // Act
        document.body.appendChild(element);

        // Assert
        // const div = element.shadowRoot.querySelector('div');

        getRecords.mockResolvedValue(Apex_KeyContact_List)
        const lightningbutton = element.shadowRoot.querySelector('lightning-button');
        lightningbutton.click();

        //checking if the values are correct
        
            const resultdatails = element.shadowRoot.querySelectorAll('p')
            expect(resultdatails.length).toBe(Apex_KeyContact_List.length);
        
    });
});