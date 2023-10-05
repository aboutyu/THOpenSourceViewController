//
//  Created by 유태훈 on 2023/10/05.
//

import Foundation

public enum THLicensesError: Error {
    case offlineStatus
    case parsingError
    case error(Error)
    case statusError(String)
    
    var message: String {
        switch self {
        case .offlineStatus:
            return "오프라인상태입니다."
        case .parsingError:
            return "데이터를 로딩에 실패 했습니다."
        case .error(let error):
            return error.localizedDescription
        case .statusError(let message):
            return message
        }
    }
}

open class THLicensesStore {
    
    private let licenseURL = URL(string: "https://api.github.com/licenses")
    
    init() {}
    
    private func getRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func fetchLicense(_ completion: @escaping (Result<[THLicensesEntity], THLicensesError>) -> Void) {
        guard let url = licenseURL else {
            completion(.failure(.parsingError))
            return
        }
                
        URLSession.shared.dataTask(with: self.getRequest(url)) { data, response, error in

            if let error = error {
                completion(.failure(.error(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.parsingError))
                return
            }

            switch response.statusCode {
            case (200...299):
                let decoder = JSONDecoder()
                do {
                    let entity = try decoder.decode([THLicensesEntity].self, from: data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(THLicensesError.parsingError))
                }
                return
            case (400...499):
                completion(.failure(.statusError("요청 측의 에러가 발생 했습니다.")))
                return
            case(500...599):
                completion(.failure(.statusError("서버 에러가 발생 했습니다.")))
                return
            default:
                completion(.failure(.statusError("알수없는 에러가 발생 했습니다.")))
                return
            }
        }.resume()
    }
    
    func fetch(_ url: URL, completion: @escaping (Result<THLicenseDetailEntity, THLicensesError>) -> Void) {
        
        URLSession.shared.dataTask(with: self.getRequest(url)) { data, response, error in

            if let error = error {
                completion(.failure(.error(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.parsingError))
                return
            }

            switch response.statusCode {
            case (200...299):
                let decoder = JSONDecoder()
                do {
                    let entity = try decoder.decode(THLicenseDetailEntity.self, from: data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(THLicensesError.parsingError))
                }
                return
            case (400...499):
                completion(.failure(.statusError("요청 측의 에러가 발생 했습니다.")))
                return
            case(500...599):
                completion(.failure(.statusError("서버 에러가 발생 했습니다.")))
                return
            default:
                completion(.failure(.statusError("알수없는 에러가 발생 했습니다.")))
                return
            }
        }.resume()
    }
}
















