import platform
import json


def get_system_info():
    info = {
        "os": platform.system(),
        "version": platform.release(),
        "platform": platform.platform(),
    }
    return json.dumps(info)


if __name__ == "__main__":
    print(get_system_info())
