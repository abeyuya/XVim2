//
//  SourceCodeEditorViewWrapper.swift
//  XVim2
//
//  Created by Ant on 22/10/2017.
//  Copyright © 2017 Shuichiro Suzuki. All rights reserved.
//

import Cocoa

@_silgen_name("scev_wrapper_call") func _get_cursor_style() -> ()
@_silgen_name("scev_wrapper_call2") func _set_cursor_style(_:CursorStyle) -> ()
@_silgen_name("scev_wrapper_call3") func _get_data_source() -> ()
@_silgen_name("scev_wrapper_call4") func _set_selected_range(_:XVimSourceEditorRange, modifiers:UInt32) -> ()
@_silgen_name("scev_wrapper_call5") func _add_selected_range(_:XVimSourceEditorRange, modifiers:UInt32) -> ()
@_silgen_name("scev_wrapper_call6") func _get_text_storage() -> ()


class SourceCodeEditorViewWrapper: NSObject {

    let a: UInt64 = 0xaaaaaaaaaaaaaaaa
    private var sourceCodeEditorViewPtr : UnsafeMutableRawPointer // 16
    private var functionToCallPtr : UnsafeMutableRawPointer // 24
    private var rax : UnsafeMutableRawPointer // 32
    private var rdx : UnsafeMutableRawPointer // 40

    private let fpSetCursorStyle = function_ptr_from_name("_T012SourceEditor0aB4ViewC11cursorStyleAA0ab6CursorE0Ofs", nil);
    private let fpGetCursorStyle = function_ptr_from_name("_T012SourceEditor0aB4ViewC11cursorStyleAA0ab6CursorE0Ofg", nil);
    private let fpGetDataSource = function_ptr_from_name("_T012SourceEditor0aB4ViewC04dataA0AA0ab4DataA0Cfg", nil);
    private let fpSetSelectedRangeWithModifiers = function_ptr_from_name("_T012SourceEditor0aB4ViewC16setSelectedRangeyAA0abF0V_AA0aB18SelectionModifiersV9modifierstF", nil);
    private let fpAddSelectedRangeWithModifiers = function_ptr_from_name("_T012SourceEditor0aB4ViewC16addSelectedRangeyAA0abF0V_AA0aB18SelectionModifiersV9modifierstF", nil);
    private let fpGetTextStorage = function_ptr_from_name("_T022IDEPegasusSourceEditor0B12CodeDocumentC16sdefSupport_textSo13NSTextStorageCyF", nil);

    private weak var editorViewProxy : SourceCodeEditorViewProxy?
    
    lazy public var dataSourceWrapper = {
        return SourceEditorDataSourceWrapper(withSourceCodeEditorViewWrapper: self)
    }()
    
    public init(withProxy proxy:SourceCodeEditorViewProxy) {
        editorViewProxy = proxy
        sourceCodeEditorViewPtr = unsafeBitCast(proxy.view, to:UnsafeMutableRawPointer.self)
        functionToCallPtr = unsafeBitCast(fpSetCursorStyle, to: UnsafeMutableRawPointer.self)
        rax = unsafeBitCast(fpSetCursorStyle, to: UnsafeMutableRawPointer.self)
        rdx = unsafeBitCast(fpSetCursorStyle, to: UnsafeMutableRawPointer.self)
        
    }
    
    var cursorStyle : CursorStyle {
        get {
            guard prepareCall(fpGetCursorStyle) else {return .verticalBar}
            _get_cursor_style();
            return CursorStyle(rawValue:NSNumber(value: UInt(bitPattern:rax)).int8Value)!
        }
        set {
            guard prepareCall(fpSetCursorStyle) else {return}
            _set_cursor_style(newValue);
        }
    }
    
    var dataSource : AnyObject? {
        guard prepareCall(fpGetDataSource) else {return nil}
        _get_data_source()
        return UnsafeMutableRawPointer(bitPattern: 0)?.distance(to:rax) == 0  ? nil : Unmanaged.fromOpaque(rax).takeUnretainedValue()
    }
    
    var textStorage : NSTextStorage? {
        guard prepareCall(fpGetTextStorage) else {return nil}
        _get_text_storage()
        return UnsafeMutableRawPointer(bitPattern: 0)?.distance(to:rax) == 0  ? nil : Unmanaged.fromOpaque(rax).takeUnretainedValue()
    }
    
    public func addSelectedRange(_ range:XVimSourceEditorRange, modifiers:XVimSelectionModifiers)
    {
        guard prepareCall(fpAddSelectedRangeWithModifiers) else {return }
        _add_selected_range(range, modifiers: modifiers.rawValue)
    }
    
    public func setSelectedRange(_ range:XVimSourceEditorRange, modifiers:XVimSelectionModifiers)
    {
        guard prepareCall(fpSetSelectedRangeWithModifiers) else {return }
        _add_selected_range(range, modifiers: modifiers.rawValue)
    }
    
    // PRIVATE
    // =======
    
    private func prepareCall(_ funcPtr: UnsafeMutableRawPointer?) -> Bool
    {
        guard let evp = editorViewProxy, let fp = funcPtr else {return false}
        if evp.view == nil {return false}
        sourceCodeEditorViewPtr = unsafeBitCast(evp.view, to:UnsafeMutableRawPointer.self)
        functionToCallPtr = fp
        return true
    }
    

}
