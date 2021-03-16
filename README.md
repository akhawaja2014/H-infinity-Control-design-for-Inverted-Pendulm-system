# H-infinity-Control-design-for-Inverted-Pendulm-system
An inverted pendulum is a pendulum in inverted position with its centre of gravity above its pivot point.
It is inherently unstable and would fall down naturally without any external force. It needs consistent external force based
on feedback of its outputs, to keep it in upright position.

The inverted pendulum is fundamental problem in control theory, due to its immense theoretical significance, along with its numerous practical applications. The theoretical value of the inverted pendulum comes from the fact that it is a nonlinear, under actuated system, meaning that its equations of motion are nonlinear differential equations, making computation of a suitable control law a tedious task.

## Mathematical Model of Cart Pendulum System
The literature on mathematical modelling is widely spread and is commonly found in control fundamental books. We revisited mathematical modelling from number of sources and reproduced it from "Introduction to Feedback Control using Design Studies" by Randal W.Beard and Timothy W.McLain. 

![alt text](freebodydiag.pdf)

The above figure shows a pendulum mounted on cart, z is the position measured relative to origin and z_dot is translational speed. Theta is the angle of the
pendulum from vertical axis and theta_dot is the angular velocity. l denotes the length of the pendulum. Pendulum is approximated as being infinitely thin. As the
figure denotes, gravity is acting in downward direction. F is the applied force which acts in the direction of z. The surface is approximated to be frictionless
and produces damping force of -b(z_dot). The centre of mass of pendulum is at half the length of pendulum.
