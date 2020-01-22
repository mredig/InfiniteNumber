//: Playground - noun: a place where people can play

import Cocoa

struct InfiniteNumber: ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, CustomStringConvertible {

	var integers: [Int8]
	var decimals: [Int8]
	var positive: Bool

	var strValue: String {
		"\(positive ? "" : "-")\(integers.reversed().map { String($0) }.joined()).\(decimals.map { String($0) }.joined())"
	}

	var description: String { strValue }

	var length: Int { integers.count }

	init(stringLiteral value: String) {
		let legalCharacters = Set("01234567890-.")
		var cleaned = value.filter { legalCharacters.contains($0) }
		if cleaned.count == 0 {
			cleaned = "0"
		}
		if let negIndex = cleaned.lastIndex(of: "-"), negIndex != cleaned.startIndex {
			cleaned = "0"
		}
		if let pointIndex = cleaned.lastIndex(of: "."), pointIndex != cleaned.firstIndex(of: ".") {
			cleaned = "0"
		}
		self.positive = !cleaned.hasPrefix("-")
		var beforeDecimal = true
		var ints = ""
		var floats = ""
		for character in cleaned {
			guard character != "." else {
				beforeDecimal = false
				continue
			}
			if beforeDecimal{
				if let number = Int("\(character)") {
					ints += "\(number)"
				}
			} else {
				if let number = Int("\(character)") {
					floats += "\(number)"
				}
			}
		}
		self.integers = ints.reversed().compactMap { Int8(String($0)) }
		self.decimals = floats.compactMap { Int8(String($0)) }
	}

	init(integerLiteral value: Int) {
		self.init(stringLiteral: String(value))
	}

	init(floatLiteral value: FloatLiteralType) {
		self.init(stringLiteral: String(value))
	}

//	static func + (rhs: InfiniteNumber, lhs: InfiniteNumber) -> InfiniteNumber {
//		var lhs = lhs
//		var rhs = rhs
//		while rhs.length < lhs.length {
//			rhs.integers.append(0)
//		}
//		while lhs.length < rhs.length {
//			lhs.integers.append(0)
//		}
//
//		var outArray = [Int8]()
//		var carryOver = false
//		for (index, digit) in rhs.integers.enumerated() {
//			var newValue = digit + lhs.integers[index] + (carryOver ? 1 : 0)
//			carryOver = false
//			if newValue >= 10 {
//				carryOver = true
//				newValue -= 10
//			}
//			outArray.append(newValue)
//		}
//		if carryOver {
//			outArray.append(1)
//		}
//		let string = outArray.reversed().map { String($0) }.joined()
//		return InfiniteNumber(stringLiteral: string)
//	}
}

let oneTwo = InfiniteNumber(stringLiteral: "45678.456")
let threeFour = InfiniteNumber(integerLiteral: 56789)
let fiveSize = InfiniteNumber(floatLiteral: 234.543)
let sevenEight = InfiniteNumber(floatLiteral: Double(integerLiteral: 345))

print(oneTwo.strValue)
print(oneTwo.integers)
print(oneTwo.decimals)
print(threeFour.strValue)
print(threeFour.integers)

//let added = oneTwo + threeFour

//added.strValue
