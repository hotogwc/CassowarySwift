/*
 
 Copyright (c) 2017, Tribal Worldwide London
 Copyright (c) 2015, Alex Birkett
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of kiwi-java nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

import XCTest
@testable import Cassowary

class ExpressionTests: XCTestCase {
    
    func testConstructors() {
        var expression = Expression()
        
        XCTAssertEqual(expression.terms.count, 0)
        assertIsCloseTo(expression.constant, 0.0)
        assertIsCloseTo(expression.value, 0.0)
        XCTAssertTrue(expression.isConstant)
        
        expression = Expression(constant: 2.0)
        XCTAssertEqual(expression.terms.count, 0)
        assertIsCloseTo(expression.constant, 2.0)
        assertIsCloseTo(expression.value, 2.0)
        XCTAssertTrue(expression.isConstant)
        
        let x = Variable("x")
        x.value = 2.0
        let term1 = Term(variable: x)
        
        let y = Variable("y")
        y.value = 3.0
        let term2 = Term(variable: y)
        
        expression = Expression(term: term1)
        XCTAssertEqual(expression.terms.count, 1)
        assertIsCloseTo(expression.constant, 0.0)
        assertIsCloseTo(expression.value, 2.0)
        XCTAssertFalse(expression.isConstant)
        
        expression = Expression(terms: [term1, term2])
        XCTAssertEqual(expression.terms.count, 2)
        assertIsCloseTo(expression.constant, 0.0)
        assertIsCloseTo(expression.value, 5.0)
        XCTAssertFalse(expression.isConstant)
    }
    
    func testDescription() {
        let x = Variable("x")
        let term1 = Term(variable: x)
        
        let y = Variable("y")
        let term2 = Term(variable: y)
        
        let expression = Expression(terms: [term1, term2])
        XCTAssertEqual(expression.description, "x + y")
    }
    
    func testUpdateTerms() {
        let x = Variable("x")
        x.value = 2.0
        let term1 = Term(variable: x)
        
        let y = Variable("y")
        y.value = 3.0
        let term2 = Term(variable: y)
        
        let expression = Expression()
        expression.terms = [term1, term2]
        XCTAssertEqual(expression.terms.count, 2)
    }
    
    func testUpdateConstant() {
        let expression = Expression()
        expression.constant = 1234.5678
        
        assertIsCloseTo(expression.constant, 1234.5678)
    }
    
    func testAlias() {
        let expression = Expression().setAlias("Test Alias", owner: self)
        XCTAssertEqual(expression.description, "Test Alias")
    }
    
}



