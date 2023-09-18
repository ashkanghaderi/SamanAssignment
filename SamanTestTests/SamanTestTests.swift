//
//  SamanTestTests.swift
//  SamanTestTests
//
//  Created by Ashkan Ghaderi on 2022-02-14.
//

@testable import SamanTest
import Domain
import XCTest
import RxSwift
import RxCocoa
import RxBlocking

enum TestError: Error {
    case test
}

class SamanTestTests: XCTestCase {
    
    var airPortUseCase: AirPortUseCaseMock!
    var mapNavigator: MapNavigatorMock!
    var viewModel: MapPointViewModel!
    
    let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        airPortUseCase = AirPortUseCaseMock()
        mapNavigator = MapNavigatorMock()
        
        viewModel = MapPointViewModel(navigator: mapNavigator, useCase: airPortUseCase)
    }
    
    func test_transform_triggerInvoked_airPortsEmited() {
        // arrange
        let trigger = PublishSubject<Void>()
        let latitude = Observable.just(51.57285)
        let longitude = Observable.just(-0.44161)
        let input = createInput(latitude: latitude, longitude: longitude)
        let output = viewModel.transform(input: input)
        
        // act
        output.airPorts.drive().disposed(by: disposeBag)
        trigger.onNext(())
        
        // assert
        XCTAssert(airPortUseCase.airPorts_Called)
    }
    
    func test_transform_triggerInvoked_getTokenEmited() {
        // arrange
        let trigger = PublishSubject<Void>()
        let latitude = Observable.just(51.57285)
        let longitude = Observable.just(-0.44161)
        let input = createInput(latitude: latitude, longitude: longitude)
        let output = viewModel.transform(input: input)
        
        // act
        output.canStart.drive().disposed(by: disposeBag)
        trigger.onNext(())
        
        // assert
        XCTAssert(airPortUseCase.token_Called)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func createInput(latitude: Observable<Double> = Observable.just(51.57285),
                             longitude: Observable<Double> = Observable.just(-0.44161),
                             viewWillAppearTrigger: Observable<Void> = Observable.just(()))
    -> MapPointViewModel.Input {
        return MapPointViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger.asDriverOnErrorJustComplete(), latitude: latitude.asDriverOnErrorJustComplete(),
            longitude: longitude.asDriverOnErrorJustComplete())
    }
    
    private func createAirPorts() -> [AirPortModel] {
        return [AirPortModel(),AirPortModel(),AirPortModel(),AirPortModel()]
    }

}
