extension Operator {
    public var operandNames: [String]? {
        func unwrap(_ operands: [Operand]) -> [String] {
            return operands.map { $0.value }
        }
        switch self {
        case .allocStack(_, _): return []
        case let .apply(_, value, _, arguments, _): return [value] + arguments
        case .beginAccess(_, _, _, _, _): return []
        case let .beginApply(_, value, _, arguments, _): return [value] + arguments
        case let .beginBorrow(operand): return [operand.value]
        case let .builtin(_, operands, _): return unwrap(operands)
        case let .condFail(operand, _): return [operand.value]
        case let .convertEscapeToNoescape(_, _, operand, _): return [operand.value]
        case let .convertFunction(operand, _, _): return [operand.value]
        case let .copyAddr(_, value, _, operand): return [value, operand.value]
        case let .copyValue(operand): return [operand.value]
        case let .deallocStack(operand): return [operand.value]
        case let .debugValue(operand, _): return [operand.value]
        case let .debugValueAddr(operand, _): return [operand.value]
        case let .destroyValue(operand): return [operand.value]
        case let .destructureTuple(operand): return [operand.value]
        case let .endAccess(_, operand): return [operand.value]
        case let .endApply(value): return [value]
        case let .endBorrow(operand): return [operand.value]
        case let .enum(_, _, maybeOperand): return maybeOperand.map{ [$0.value] } ?? []
        case .floatLiteral(_, _): return []
        case .functionRef(_, _): return []
        case .globalAddr(_, _): return []
        case let .indexAddr(addr, index): return [addr.value, index.value]
        case .integerLiteral(_, _): return []
        case let .load(_, operand): return [operand.value]
        case let .markDependence(operand, on): return [operand.value, on.value]
        case .metatype(_): return []
        case let .partialApply(_, _, value, _, arguments, _): return [value] + arguments
        case let .pointerToAddress(operand, _, _): return [operand.value]
        case let .releaseValue(operand): return [operand.value]
        case let .retainValue(operand): return [operand.value]
        case let .store(value, _, operand): return [value, operand.value]
        case .stringLiteral(_, _): return []
        case let .strongRelease(operand): return [operand.value]
        case let .strongRetain(operand): return [operand.value]
        case let .struct(_, operands): return unwrap(operands)
        case let .structElementAddr(operand, _): return [operand.value]
        case let .structExtract(operand, _): return [operand.value]
        case let .thinToThickFunction(operand, _): return [operand.value]
        case let .tuple(elements):
            switch elements {
            case let .unlabeled(operands): return unwrap(operands)
            case let .labeled(_, operands): return operands
            }
        case let .tupleExtract(operand, _): return [operand.value]
        case .unknown(_): return nil
        case .witnessMethod(_, _, _, _): return []
        }
    }
}