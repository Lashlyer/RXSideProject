
import Foundation
import Alamofire
import RxSwift

public class HttpRequest: NSObject {
    
    public static let Singleton = HttpRequest()
    
    public func get(url: String) -> Single<HttpStatus<Data>> {
        Single<HttpStatus<Data>>.create { closure in
            
            let request = AF.request(url, method: .get).response(queue: .global()) { response in
                switch response.result {
                
                case .success(let data):
                    if let datas = data {
                        closure(.success(.data(datas)))
                    } else {
                        closure(.failure(AppError("App data == nil")))
                    }
                case .failure(let error):
                    closure(.failure(AppError(error)))
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    public func decodeApiResult<T: UserDataResponse>(url: String) -> Single<HttpStatus<T>> {
        get(url: url).flatMap { status -> Single<HttpStatus<T>> in
             switch status {
             case .data(let d):
                do {
                    let result:T = try ResultDecoder.parser(d)
                    return Single.just(.data(result))
                } catch let error as AppError {
                    return Single.just(.error(error))
                }
             case .error(let e):
                 return Single.just(.error(e))
             }
        }
    }
}
