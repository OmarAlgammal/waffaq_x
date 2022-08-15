
abstract class AddDataState{}

class AddDataInitState extends AddDataState{}

class AddingData extends AddDataState{}

class DataAddedSuccessfully extends AddDataState{}

class FailedToAddData extends AddDataState{}