unit Server.Response.Intf;

interface

uses System.JSON, Data.DB;

type
  IResponse = interface
    ['{5D39ED57-D042-42A8-A7D2-2C9D39173DF5}']
    function CheckAssigned(const AObject: TObject; const AError: string = ''): IResponse;
    function CheckNotAssigned(const AObject: TObject; const AError: string = ''): IResponse;
    function CheckIsEmpty(const AValue: string; const AError: string = ''): IResponse;
    function CheckNotIsEmpty(const AValue: string; const AError: string = ''): IResponse;
    function CheckIsTrue(const ACheck: Boolean; const AError: string = ''): IResponse;
    function CheckIsFalse(const ACheck: Boolean; const AError: string = ''): IResponse;
    function SetError(const AMessage: string): IResponse; overload;
    function SetError(const AMessage: string; const AField: TField): IResponse; overload;
    function SetError(const AMessage, AFieldName: string): IResponse; overload;
    function Error: Boolean;
    function Success: Boolean;
    function GetErrors: TJSONArray;
    function GetErrorsMessage: string;
  end;

implementation

end.
