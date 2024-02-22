import { getToken } from "firebase/messaging";
import { messaging } from "./initialize";
import { vapidKey } from "./config";

export const generate = async () => {
  return await getToken(messaging, { vapidKey: vapidKey });
};
